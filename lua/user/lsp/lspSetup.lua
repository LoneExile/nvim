local _, lsp = pcall(require, 'lsp-zero')

require('user.lsp.settings.sumneko').setup(lsp)
require('user.lsp.settings.pyright').setup(lsp)
require('user.lsp.settings.jsonls').setup(lsp)
require('user.lsp.settings.vuels').setup(lsp)
-- require('user.lsp.settings.volar').setup(lsp)
