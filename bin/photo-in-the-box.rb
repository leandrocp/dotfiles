#!/usr/bin/env ruby

#
# https://github.com/ebobby/photo-organizer
#
# find ~/my/photos -type f -print0 | xargs -I{} -0 ruby po.rb {} ~/my/organized/photos
#

require 'rubygems'
require 'bundler/setup'
require 'exifr'
require 'fileutils'
require 'tempfile'
require 'optparse'

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

  def dir_by_date
    return "unknown" unless has_exif?

    "%4i/%02i/%02i" % [ @exif.date_time_original.year,
      @exif.date_time_original.month,
      @exif.date_time_original.day ]
  end

  def copied_file_name
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
    @file = @photo.copied_file_name
    @photo_dest = File.join(@dir, @file)
  end

  def process
    if File.exists?(@photo_dest)
      puts "Skipping #{@photo.source} -> #{@photo_dest}. File already exists!"
      exit
    end
    make_dir
    copy_photo
    delete_source
    delete_empty_dir
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
