import { expect, test } from 'claude-code/testing'

const BAND = {
  plugin: 'suggested-replies',
  component: 'AbovePrompt',
  requestId: 'above-prompt',
  viewport: { columns: 110, rows: 30 },
  props: {
    hasSurvey: false,
    isCollapsed: false,
    isWorking: false,
    maxRows: 10,
    bodyColumns: 100,
    scroll: { offset: 0, bodyRows: 10 },
    view: {},
  },
} as const

const usage = { input_tokens: 10, output_tokens: 5, cache_read_input_tokens: 0, cache_creation_input_tokens: 0 }

function stubSession(on, replies: string[]) {
  on('session.messages', () => ({
    value: [
      { role: 'user', text: 'add retry to Billing.Client', toolUses: [] },
      { role: 'assistant', text: 'Done. Want me to open a PR?', toolUses: [] },
    ],
  }))
  on('session.surfaces', () => ({ value: ['terminal'] }))
  on('model.complete', () => ({ value: { isAnswered: true, text: replies.shift() ?? '', usage } }))
  on('turn.complete', () => ({ text: '' }))
  on('prompt.submit', ($, e) => ({ text: e.text }))
}

const complete = ($) =>
  $.turn.complete({ turnId: 't', reason: 'answer', answer: 'Done.', durationMs: 10, isAborted: false, usage: null })

test('suggestions from the model become buttons that fill the prompt', async ($, on) => {
  const filled: string[] = []
  stubSession(on, ['1. Yes, open the PR\n- "Add jitter too"\n\nThird one is dropped'])
  on('prompt.fill', ($, e) => {
    filled.push(e.text)
    return { isFilled: true, text: e.text, cursor: e.text.length }
  })

  await complete($)
  for (const surface of ['terminal', 'desktop'] as const) {
    const ui = await $.ui.mount({ ...BAND, surface })
    expect(await ui.find({ key: 'reply-0' })).toBeDefined()
    expect((await ui.find({ key: 'reply-1' }))?.props.label).toBe('Add jitter too')
    expect(await ui.find({ key: 'reply-2' })).toBeUndefined()
    await ui.press({ key: 'reply-0' })
    await ui.unmount()
  }
  expect(filled).toEqual(['Yes, open the PR', 'Yes, open the PR'])
})

test('typing keeps only the suggestions that start with the draft, with their numbers', async ($, on) => {
  stubSession(on, ['Open a PR\nMake the backoff linear'])
  on('prompt.edit', ($, e) => {
    const text = e.text.slice(0, e.start) + e.inputText + e.text.slice(e.end)
    return { text, cursor: e.start + e.inputText.length }
  })

  await complete($)
  await $.prompt.edit({ origin: { kind: 'composer' }, text: '', cursor: 0, start: 0, end: 0, inputText: 'make' })

  const ui = await $.ui.mount({ ...BAND, surface: 'terminal' })
  expect(await ui.find({ key: 'reply-0' })).toBeUndefined()
  expect((await ui.find({ key: 'reply-1' }))?.props.hotkey).toBe('2')
  await ui.unmount()

  // A lone digit picks a button by its hotkey, so every button stays
  await $.prompt.edit({ origin: { kind: 'composer' }, text: 'make', cursor: 4, start: 0, end: 4, inputText: '2' })
  const picking = await $.ui.mount({ ...BAND, surface: 'terminal' })
  expect(await picking.find({ key: 'reply-0' })).toBeDefined()
  expect(await picking.find({ key: 'reply-1' })).toBeDefined()
})

test('nothing shows while Claude works, and submitting clears the buttons', async ($, on) => {
  stubSession(on, ['Yes, open the PR'])
  await complete($)

  const working = await $.ui.mount({ ...BAND, surface: 'terminal', props: { ...BAND.props, isWorking: true } })
  expect(await working.find({ key: 'reply-0' })).toBeUndefined()
  await working.unmount()

  await $.prompt.submit({ text: 'something else' })
  const ui = await $.ui.mount({ ...BAND, surface: 'terminal' })
  expect(await ui.find({ key: 'reply-0' })).toBeUndefined()
})
