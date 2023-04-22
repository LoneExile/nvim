local disable_distribution_plugins = {
  gzip = 1, -- Support for .gz compressed files
  tar = 1, -- Support for .tar archive files
  tarPlugin = 1, -- Extended support for .tar archive files
  zip = 1, -- Support for .zip archive files
  zipPlugin = 1, -- Extended support for .zip archive files
  getscript = 1, -- Plugin for downloading Vim scripts
  getscriptPlugin = 1, -- Plugin for downloading and installing Vim scripts
  vimball = 1, -- Support for Vimball archives (.vba)
  vimballPlugin = 1, -- Extended support for Vimball archives (.vba)
  matchit = 1, -- Extended % matching for HTML, LaTeX, and many other languages
  matchparen = 1, -- Highlights matching pairs of parentheses, brackets, and braces
  ['2html_plugin'] = 1, -- Converts the current buffer to an HTML file with syntax highlighting
  logiPat = 1, -- Search utility using logical patterns
  rrhelper = 1, -- Plugin for recording and replaying keystrokes
  netrw = 1, -- Network-oriented reading, writing, and browsing
  netrwPlugin = 1, -- Extended network-oriented reading, writing, and browsing
  netrwSettings = 1, -- Settings for the netrw plugin
  netrwFileHandlers = 1, -- Filetype handlers for the netrw plugin

  tohtml = 1, -- Converts the current buffer to an HTML file with syntax highlighting
  spellfile_plugin = 1, -- Manages spell files
  tutor = 1, -- Interactive tutorial for learning basic Vim commands
  rplugin = 1, -- Support for remote plugins that run in a separate process
  syntax = 1, -- Syntax highlighting support
  synmenu = 1, -- Syntax highlighting menu items
  optwin = 1, -- Option window for browsing and setting options in Vim
  compiler = 1, -- Compiler plugin support for different compilers and build systems
  bugreport = 1, -- Utility for generating Vim bug reports
  ftplugin = 1, -- FileType plugin support for filetype-specific settings and functions
}

for k, v in pairs(disable_distribution_plugins) do
  vim.g['loaded_' .. k] = v
end
