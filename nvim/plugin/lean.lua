-- Required for nvim-compe to work.
-- Note that nvim-compe is deprecated and replaced by a newer plugin
-- https://github.com/hrsh7th/nvim-compe#warning
-- For the minute, it will still work fine, but in the future this
-- example will be updated to show how to use the replacement plugin.
vim.opt.completeopt = { 'menuone', 'noselect' }

-- Always show sign column.
-- The sign column is used by the LSP support to show diagnostics
-- (the E, W, etc. characters on the side)
-- as well as by the Lean plugin to show the orange bars.
-- By default the sign column is only shown if there are signs to show,
-- which means the buffer will constantly jump right and left.
vim.opt.signcolumn = "yes:1"

-- Enable nvim-compe, with 3 completion sources, including LSP
require'compe'.setup{
  autocomplete = false,
  source = {
    nvim_lsp = { priority = 99 },
    nvim_lua = { priority = 99 },
    path = { priority = 99 },
  }
}
-- If you wish to use Tab to complete, include here the code found at:
-- https://github.com/hrsh7th/nvim-compe#how-to-use-tab-to-navigate-completion-menu

-- Configure the language server:

-- You may want to reference the nvim-lspconfig documentation, found at:
-- https://github.com/neovim/nvim-lspconfig#keybindings-and-completion
-- The below is just a simple initial set of mappings which will be bound
-- within Lean files.
local function on_attach(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    local function cmd(mode, key, cmd)
      vim.api.nvim_buf_set_keymap(
        bufnr,
        mode,
        key,
        '<cmd>lua ' .. cmd .. '<CR>',
        {noremap = true}
      )
    end

    -- Autocomplete using the Lean language server
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- gd in normal mode will jump to definition
    cmd('n', 'gd', 'vim.lsp.buf.definition()')
    -- K in normal mode will show the definition of what's under the cursor
    cmd('n', 'K', 'vim.lsp.buf.hover()')

    -- <leader>n will jump to the next Lean line with a diagnostic message on it
    -- <leader>N will jump backwards
    cmd('n', '<leader>n', 'vim.lsp.diagnostic.goto_next{popup_opts = {show_header = false}}')
    cmd('n', '<leader>N', 'vim.lsp.diagnostic.goto_prev{popup_opts = {show_header = false}}')

    -- <leader>K will show all diagnostics for the current line in a popup window
    cmd('n', '<leader>K', 'vim.lsp.diagnostic.show_line_diagnostics{show_header = false}')

    -- <leader>q will load all errors in the current lean file into the location list
    -- (and then will open the location list)
    -- see :h location-list if you don't generally use it in other vim contexts
    cmd('n', '<leader>q', 'vim.lsp.diagnostic.set_loclist()')
end

-- Enable lean.nvim, and enable abbreviations and mappings
require('lean').setup{
    abbreviations = { builtin = true },
    lsp = { on_attach = on_attach },
    lsp3 = { on_attach = on_attach },
    mappings = true,
}

-- Update error messages even while you're typing in insert mode
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = true,
    virtual_text = { spacing = 4 },
    update_in_insert = true,
  }
)
