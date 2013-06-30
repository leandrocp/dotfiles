#!/usr/bin/env ruby

#
# This is just an ugly hack to organize my huge photo collection.
# It's just a version to test things out. Do not expect good code (for now)
#
# TODO
#  Make it readable
#  Organize objets
#  Accept regex arguments (like *.jpg)
#  Finally, error checking
#
# Inspiration from https://github.com/ebobby/photo-organizer
#
# Execute this thing recursively:
#  find ~/my/photos -type f -print0 | xargs -I{} -0 ruby photo-in-the-box.rb {} ~/my/organized/photos
#
# Count files recursively in a dir:
#  find ~/dir -type f | wc -l
#

require 'rubygems'
require 'bundler/setup'
require 'exifr'
require 'fileutils'
require 'tempfile'
require 'optparse'
require 'systemu'

class InvalidPhotoFile < StandardError; end
class InvalidDestinationDir < StandardError; end

class Photo
  attr_accessor :source, :dir, :exif

  def initialize(source)
    raise InvalidPhotoFile unless valid?(source)
    @source = File.expand_path(source)
    @dir = File.expand_path(File.dirname(source))
    @exif ||= EXIFR::JPEG.new(@source) rescue nil
  end

  def has_exif?
    not @exif.date_time_original.nil?
  end

  def diff?(dest_photo)
    # http://en.positon.org/post/Compare-/-diff-between-two-images
    command = "convert #{@source} #{dest_photo} -resize '400x300!' MIFF:- | compare -metric AE -fuzz '50%' - null:"
    status, stdout, stderr = systemu command
    # Don't know why but this command output to stderr instead of stdout
    diff = stderr.to_i || stdout.to_i
    diff > 0
  end

  def equal?(dest_photo)
    not diff?(dest_photo)
  end

  def size
    @exif.width * @exif.height
  end

  def dir_by_date
    return "unknown" unless has_exif?

    "%4i/%02i/%02i" % [ @exif.date_time_original.year,
      @exif.date_time_original.month,
      @exif.date_time_original.day ]
  end

  def destination_file_name
    return File.basename(@source) unless has_exif?

    "%02i-%02i-%02i#{File.extname(@source)}" % [ @exif.date_time_original.hour,
      @exif.date_time_original.min,
      @exif.date_time_original.sec ]
  end

  private
  def valid?(file)
    photo_file = File.expand_path(file)
    File.exists?(photo_file) && File.extname(photo_file) =~ /jp?g/i
  end
end

class Destination
  attr_accessor :path, :dir, :file

  def initialize(path, photo)
    raise InvalidDestinationDir unless valid?(path)
    @path = File.expand_path(path)
    @photo = photo
    @dir = File.join(@path, @photo.dir_by_date)
    @photo_dest = File.join(@dir, @photo.destination_file_name)
  end

  def process
    if File.exists?(@photo_dest)
      dest = Photo.new @photo_dest

      if @photo.equal?(@photo_dest) and dest.size >= @photo.size
        puts "Skipping #{@photo.source} -> #{@photo_dest}. Dest file size is bigger or equal!"
        exit
      end

      if @photo.diff?(@photo_dest)
        file = @photo.destination_file_name
        version = file.match(/v([0-9])\./i).captures[0] rescue "1"
        extname = File.extname(file)
        basename = File.basename(file, extname)
        new_version_file_name = "#{basename}-v#{version}#{extname}"
        @photo_dest = File.join(@dir, new_version_file_name)
        return process
      end

    end

    make_dir
    copy_photo
    #delete_source
    #delete_empty_dir
    success_message
  end

  private
  def valid?(path)
    dest_path = File.expand_path(path)
    File.directory?(dest_path)
  end

  def make_dir
    FileUtils.mkdir_p(@dir)
  end

  def copy_photo
    FileUtils.cp @photo.source, @photo_dest
  end

  def delete_source
    return unless File.exists?(@photo_dest)
    FileUtils.rm(@photo.source)
  end

  def delete_empty_dir
    return unless (Dir.entries(@photo.dir) - %w{ . .. }).empty?
    puts @photo.dir
    Dir.rmdir @photo.dir
  end

  def success_message
    puts "#{@photo.source} -> #{@photo_dest}"
  end
end

photo = Photo.new(ARGV[0])
dest = Destination.new(ARGV[1], photo)

dest.process
