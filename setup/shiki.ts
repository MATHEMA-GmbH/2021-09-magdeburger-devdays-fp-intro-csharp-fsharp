import { defineShikiSetup } from '@slidev/types'

// for a list of themes, see https://github.com/shikijs/shiki/blob/main/docs/themes.md
export default defineShikiSetup(() => {
  return {
    theme: {
      dark: 'material-darker',
      light: 'github-light',
    },
  }
})
