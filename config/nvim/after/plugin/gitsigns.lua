local status_ok, gitsigns = pcall(require, "gitsigns")

if not status_ok or vim.g.vscode then return end

gitsigns.setup {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "Gitsigns: Stage hunk" })
    map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "Gitsigns: Resent hunk" })
    map('n', '<leader>hS', gs.stage_buffer, { desc = "Gitsigns: Stage buffer" })
    map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Gitsigns: Undo stage hunk" })
    map('n', '<leader>hR', gs.reset_buffer, { desc = "Gitsigns: Reset buffer" })
    map('n', '<leader>hp', gs.preview_hunk, { desc = "Gitsigns: Preview hunk" })
    map('n', '<leader>hb', function() gs.blame_line { full = true } end, { desc = "Gitsigns: Blame line" })
    map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Gitsigns: Toggle blame current line" })
    map('n', '<leader>hd', gs.diffthis, { desc = "Gitsigns: Diff this" })
    map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Gitsigns: Diff this ~" })
    map('n', '<leader>td', gs.toggle_deleted, { desc = "Gitsings: Toggle delete" })

    -- Text object
    map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
