-- Harper: privacy-first grammar/spell checker via harper-ls
-- https://writewithharper.com/docs/integrations/neovim
return {
  cmd = { 'harper-ls', '--stdio' },
  filetypes = { 'markdown', 'text', 'gitcommit', 'tex', 'typst' },
  settings = {
    ['harper-ls'] = {
      linters = {
        -- Programmer-friendly defaults: cut the noisiest false-positives.
        SpellCheck = false,
        SentenceCapitalization = false,
        SpelledNumbers = false,
        AnA = true,
        UnclosedQuotes = true,
        LongSentences = true,
        RepeatedWords = true,
        Spaces = true,
        CorrectNumberSuffix = true,
      },
      codeActions = {
        ForceStable = false,
      },
      markdown = {
        IgnoreLinkTitle = false,
      },
      diagnosticSeverity = 'hint',
      isolateEnglish = false,
      dialect = 'American',
    },
  },
}
