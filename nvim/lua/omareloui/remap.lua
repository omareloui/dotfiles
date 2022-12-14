local inoremap = require("omareloui.keymap").inoremap
local nnoremap = require("omareloui.keymap").nnoremap
local vnoremap = require("omareloui.keymap").vnoremap
local xnoremap = require("omareloui.keymap").xnoremap

nnoremap("Y", "y$")

-- Move text
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")
inoremap("<C-j>", ":m .+1<CR>==")
inoremap("<c-k>", ":m .-2<cr>==")

-- Hold the indent mode
vnoremap("<", "<gv")
vnoremap(">", ">gv")

-- Doens't store the new text on pasting on selected text
vnoremap("p", '"_dP')


if vim.g.vscode then
  vim.cmd [[
    function! s:split(...) abort
        let direction = a:1
        let file = a:2
        call VSCodeCall(direction == 'h' ? 'workbench.action.splitEditorDown' : 'workbench.action.splitEditorRight')
        if file != ''
            call VSCodeExtensionNotify('open-file', expand(file), 'all')
        endif
    endfunction

    function! s:splitNew(...)
        let file = a:2
        call s:split(a:1, file == '' ? '__vscode_new__' : file)
    endfunction

    function! s:closeOtherEditors()
        call VSCodeNotify('workbench.action.closeEditorsInOtherGroups')
        call VSCodeNotify('workbench.action.closeOtherEditors')
    endfunction

    function! s:manageEditorSize(...)
        let count = a:1
        let to = a:2
        for i in range(1, count ? count : 1)
            call VSCodeNotify(to == 'increase' ? 'workbench.action.increaseViewSize' : 'workbench.action.decreaseViewSize')
        endfor
    endfunction

    command! -complete=file -nargs=? Split call <SID>split('h', <q-args>)
    command! -complete=file -nargs=? Vsplit call <SID>split('v', <q-args>)
    command! -complete=file -nargs=? New call <SID>split('h', '__vscode_new__')
    command! -complete=file -nargs=? Vnew call <SID>split('v', '__vscode_new__')
    command! -bang Only if <q-bang> == '!' | call <SID>closeOtherEditors() | else | call VSCodeNotify('workbench.action.joinAllGroups') | endif

    nnoremap <silent> <C-w>s :call <SID>split('h')<CR>
    xnoremap <silent> <C-w>s :call <SID>split('h')<CR>

    nnoremap <silent> <C-w>v :call <SID>split('v')<CR>
    xnoremap <silent> <C-w>v :call <SID>split('v')<CR>

    nnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>
    xnoremap <silent> <C-w>n :call <SID>splitNew('h', '__vscode_new__')<CR>


    nnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>
    xnoremap <silent> <C-w>= :<C-u>call VSCodeNotify('workbench.action.evenEditorWidths')<CR>

    nnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <silent> <C-w>> :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    xnoremap <silent> <C-w>+ :<C-u>call <SID>manageEditorSize(v:count, 'increase')<CR>
    nnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <silent> <C-w>< :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    nnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>
    xnoremap <silent> <C-w>- :<C-u>call <SID>manageEditorSize(v:count, 'decrease')<CR>

    " Better Navigation
    nnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    xnoremap <silent> <C-j> :call VSCodeNotify('workbench.action.navigateDown')<CR>
    nnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    xnoremap <silent> <C-k> :call VSCodeNotify('workbench.action.navigateUp')<CR>
    nnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    xnoremap <silent> <C-h> :call VSCodeNotify('workbench.action.navigateLeft')<CR>
    nnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
    xnoremap <silent> <C-l> :call VSCodeNotify('workbench.action.navigateRight')<CR>
  ]]

  -- Get folding working with vscode neovim plugin
  nnoremap("zM", ":call VSCodeNotify('editor.foldAll')<CR>")
  nnoremap("zc", ":call VSCodeNotify('editor.fold')<CR>")
  nnoremap("zr", ":call vscodenotify('editor.unfoldall')<cr>")
  nnoremap("zC", ":call VSCodeNotify('editor.foldRecursively')<CR>")
  nnoremap("zo", ":call VSCodeNotify('editor.unfold')<CR>")
  nnoremap("zO", ":call VSCodeNotify('editor.unfoldRecursively')<CR>")
  nnoremap("za", ":call VSCodeNotify('editor.toggleFold')<CR>")

  vim.cmd [[
    function! MoveCursor(direction) abort
      if(reg_recording() == '' && reg_executing() == '')
          return 'g'.a:direction
      else
          return a:direction
      endif
    endfunction

    nmap <expr> j MoveCursor('j')
    nmap <expr> k MoveCursor('k')
  ]]

  -- Open whichkey
  nnoremap("<leader>", ":call VSCodeNotify('whichkey.show')<CR>")
  xnoremap("<leader>", ":call VSCodeNotify('whichkey.show')<CR>")
else
  inoremap("jk", "<Esc>")

  -- Open file tree
  nnoremap("<leader>pv", "<cmd>Ex<CR>")
  nnoremap("<leader>e", "<cmd>Lex 30<CR>")

  -- Move text
  nnoremap("<leader>j", ":m .+1 <CR>==")
  nnoremap("<leader>k", ":m .-2 <CR>==")

  -- Telescope
  nnoremap("<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<CR>")
end
