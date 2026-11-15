// Suggested replies: after each answer, a small model predicts what you are
// likely to send next and shows it as buttons above the prompt. Pressing one
// (or typing its digit into an empty prompt) puts the text in the prompt box.

const PANE = 'suggested-replies'
const MAX = 2

const SYSTEM = `You write suggested replies for a coding agent's chat: the messages the user is most likely to send next.
Read the conversation, then write 1 or 2 suggested replies in the user's own voice and style.
Most next messages accept or answer what the assistant proposed or asked, take the next step toward the user's goal, or ask for one precise change to what the assistant just produced.
Name the specific action ("Yes, deploy it to staging", not "Yes"). Keep each under 80 characters.
Write one per line, most likely first, with no numbering, bullets, quotes, or commentary. If you cannot tell what the user will say, write nothing.`

// What the band shows, the draft it is filtered by, and which generation is current
let suggestions = []
let draft = ''
let gen = 0
let paneOpen = false

// The suggestions that start with the draft, each with its number in the full list
function visible() {
  // A lone digit is the person picking a button by its hotkey, so it filters nothing
  const d = /^\d$/.test(draft) ? '' : draft.trim().toLowerCase()
  return suggestions
    .map((text, i) => ({ text, i }))
    .filter(({ text }) => text.toLowerCase().startsWith(d) && text.length > d.length)
}

function transcript(messages) {
  return messages
    .slice(-8)
    .filter((m) => m.text.trim())
    .map((m) => (m.role === 'user' ? 'User: ' : 'Assistant: ') + m.text.trim().slice(-1500))
    .join('\n\n')
}

export function parse(text) {
  return text
    .split('\n')
    .map((l) => l.replace(/^\s*(?:[-*•]|\d+[.)])\s*/, '').replace(/^["“](.*)["”]$/, '$1').trim())
    .filter((l) => l.length > 0 && l.length <= 120)
    .slice(0, MAX)
}

async function inVSCode($) {
  return (await $.session.surfaces()).includes('vscode')
}

async function show($, next) {
  suggestions = next
  $.ui.invalidate('ui.render')
  // The VS Code panel has no band above the prompt, so it gets a small pane instead
  if (await inVSCode($)) {
    if (suggestions.length && !paneOpen) {
      paneOpen = true
      await $.ui.open({ id: PANE, title: 'Suggested replies' })
    } else if (!suggestions.length && paneOpen) {
      paneOpen = false
      await $.ui.close({ id: PANE })
    }
  }
}

async function generate($, mine) {
  const prompt = transcript(await $.session.messages())
  if (!prompt) return
  const r = await $.model.complete({ model: 'haiku', system: SYSTEM, prompt, maxTokens: 200, timeoutMs: 20000 })
  // A newer turn or prompt started while this one was generating
  if (mine !== gen || !r.isAnswered) return
  await show($, parse(r.text))
}

function buttons($, e, list) {
  const { Box, Button } = $.ui.resolve(e)
  // A rounded border around each button makes it read as a balloon
  const pill = ({ text: s, i }) =>
    Box({
      key: 'pill-' + i,
      borderStyle: 'round',
      borderColor: 'subtle',
      paddingX: 1,
      children: [
        Button({
          key: 'reply-' + i,
          label: s,
          hotkey: String(i + 1),
          plain: true,
          onPress: () => $.prompt.fill({ text: s }),
        }),
      ],
    })
  return Box({ flexDirection: 'row', columnGap: 1, flexWrap: 'wrap', children: list.map(pill) })
}

export function register(on) {
  on('turn.complete', async ($, e, next) => {
    // Only the main conversation's answers, not subagents' runs or interrupted turns
    if (!e.agentId && e.reason === 'answer') {
      const mine = ++gen
      // Not awaited: the turn ends now and the buttons appear when the model answers
      generate($, mine).catch(() => {})
    }
    return next(e)
  })

  on('prompt.submit', async ($, e, next) => {
    gen++
    draft = ''
    await show($, [])
    return next(e)
  })

  // Typing filters the buttons to the ones that start with the draft
  on('prompt.edit', async ($, e, next) => {
    const r = await next(e)
    if (r.text !== draft) {
      draft = r.text
      if (suggestions.length) $.ui.invalidate('ui.render')
    }
    return r
  })

  on('ui.render', { component: 'AbovePrompt' }, async ($, e, next) => {
    const list = visible()
    if (e.props.isWorking || e.props.hasSurvey || !list.length) return next(e)
    return buttons($, e, list)
  })

  on('ui.render', { component: 'Pane' }, async ($, e, next) => {
    if (e.requestId !== PANE) return next(e)
    return buttons($, e, visible())
  })

  on('ui.close', async ($, e, next) => {
    if (e.id === PANE) paneOpen = false
    return next(e)
  })
}
