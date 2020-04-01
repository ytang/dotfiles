" -*- mode: vimrc -*-
"vim: ft=vim

function! Layers()
" Configuration Layers declaration.
" Add layers with `Layer '+layername'` and add individual packages
" with `ExtraPlugin 'githubUser/Repo'`.

  Layer '+core/behavior'
  Layer '+core/sensible'
  Layer '+completion/coc' " Or '+completion/deoplete'
  Layer '+completion/snippets'
  Layer '+checkers/ale' " Or '+checkers/neomake'
  Layer '+checkers/quickfix'
  Layer '+nav/buffers'
  Layer '+nav/comments'
  Layer '+nav/files'
  Layer '+nav/fzf' " Or '+nav/fuzzy'
  Layer '+nav/jump'
  Layer '+nav/quit'
  Layer '+nav/start-screen'
  Layer '+nav/text'
  Layer '+nav/tmux'
  Layer '+nav/windows'
  Layer '+scm/git'
  Layer '+specs/testing'
  Layer '+tools/format'
  Layer '+tools/language-server'
  Layer '+tools/multicursor'
  Layer '+tools/terminal'
  Layer '+ui/airline'
  Layer '+ui/dynamic-cursor'
  Layer '+ui/toggles'

  " Language layers.
  "Layer '+lang/elm'
  "Layer '+lang/haskell'
  "Layer '+lang/rust'
  "Layer '+lang/go'
  "Layer '+lang/fsharp'
  "Layer '+lang/java'
  "Layer '+lang/javascript'
  "Layer '+lang/purescript'
  Layer '+lang/python'
  "Layer '+lang/ruby'
  "Layer '+lang/php'
  Layer '+lang/vim'

  " Additional plugins.
  ExtraPlugin 'arcticicestudio/nord-vim'
  ExtraPlugin 'jreybert/vimagit'
  ExtraPlugin 'tiagofumo/vim-nerdtree-syntax-highlight'
endfunction

function! UserInit()
" This block is called at the very startup of Spaceneovim initialization
" before layers configuration.

  " Set language server backend to coc.nvim.
  let g:spLspBackend = 'coc-lsp'
  " Show type/doc information when leaving cursor on an item. Also accessible
  " via `SPC l i`.
  let g:spCocHoverInfo = 1
  " Set Haskell backend to LSP.
  let g:spHaskellBackend = 'lsp'
  " Don't run formatter on save.
  let g:spFormatOnSave = 0
endfunction

function! UserConfig()
" This block is called after Spaceneovim layers are configured.

  let g:dotspaceneovim_restore_cursor_to_style = 'block'
  let g:NERDTreeLimitedSyntax = 1
  let g:nord_italic = 1
  let g:nord_italic_comments = 1
  let $VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"

  set cursorline
  set norelativenumber
  set scrolloff=999
  set wildmode=list:longest,full

  augroup LineTooLong
    autocmd!
    autocmd BufEnter,WinEnter * call clearmatches() | call matchadd('ColorColumn', '\%>80v.\+', -1)
  augroup END

  augroup SecureUndo
    autocmd!
    autocmd BufWritePre /tmp/* setlocal noundofile
  augroup END

  nnoremap <leader>/ :noh<CR>
  nunmap <leader><leader>
  SpNMap 'gs', 'status', 'Magit'

  SetThemeWithBg 'dark', 'nord', 'nord'
  highlight! link TermCursor Cursor
  highlight! TermCursorNC gui=underline cterm=underline
endfunction

" Do NOT remove these calls!
call spaceneovim#init()
call Layers()
call UserInit()
call spaceneovim#bootstrap()
call UserConfig()
