" -*- mode: vimrc -*-
"vim: ft=vim

function! Layers()
" Configuration Layers declaration.
" Add layers with `Layer '+layername'` and add individual packages
" with `ExtraPlugin 'githubUser/Repo'`.

  Layer '+core/behavior'
  Layer '+core/sensible'
  Layer '+completion/deoplete' " Or '+completion/nvim-completion-manager'
  Layer '+completion/snippets'
  Layer '+checkers/ale' " Or '+checkers/neomake'
  Layer '+checkers/quickfix'
  Layer '+nav/buffers'
  Layer '+nav/comments'
  Layer '+nav/files'
  Layer '+nav/fzf' " Or '+nav/fuzzy'
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
  "Layer '+lang/haskell' " Set backend with e.g. let g:spHaskellBackend = 'intero', in UserInit
  Layer '+lang/javascript'
  Layer '+lang/python'
  "Layer '+lang/ruby'
  Layer '+lang/vim'

  " Additional plugins.
  ExtraPlugin 'airblade/vim-rooter'
  ExtraPlugin 'arcticicestudio/nord-vim'
  ExtraPlugin 'carlitux/deoplete-ternjs'
  ExtraPlugin 'ryanoasis/vim-devicons'
  ExtraPlugin 'tiagofumo/vim-nerdtree-syntax-highlight'
  ExtraPlugin 'Xuyuanp/nerdtree-git-plugin'
endfunction

function! UserInit()
" This block is called at the very startup of Spaceneovim initialization
" before layers configuration.

  let g:spFormatOnSave = 0
endfunction

function! UserConfig()
" This block is called after Spaceneovim layers are configured.

  let g:dotspaceneovim_restore_cursor_to_style = 'block'
  let g:echodoc#enable_at_startup = 1
  let g:LanguageClient_serverCommands = get(g:, 'LanguageClient_serverCommands', {})
  let g:LanguageClient_serverCommands.python = ['$HOME/.local/bin/pyls']
  let g:NERDTreeLimitedSyntax = 1
  let g:nord_comment_brightness = 12
  let g:nord_italic = 1
  let g:nord_italic_comments = 1
  let g:rooter_change_directory_for_non_project_files = 'current'
  let g:rooter_silent_chdir = 1
  let g:startify_change_to_dir = 0
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
  set cmdheight=1
  set colorcolumn=80
  set cursorline
  set norelativenumber
  set noshowmode
  set scrolloff=999
  set wildmode=list:longest,full
  SetThemeWithBg 'dark', 'nord', 'nord'
endfunction

" Do NOT remove these calls!
call spaceneovim#init()
call Layers()
call UserInit()
call spaceneovim#bootstrap()
call UserConfig()
