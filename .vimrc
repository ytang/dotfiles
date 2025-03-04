"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Put an empty, self-clearing group somewhere near the top of the vimrc,
" so that we can add autocommands to that group from anywhere.
augroup vimStartup
  autocmd!
augroup END


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu
set wildmode=longest:full,full

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-l> to temporarily turn off highlighting; see the
" mapping of <C-l> below)
set hlsearch

" Do incremental searching when it's possible to timeout
if has('reltime')
  set incsearch
endif

" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
set nomodeline


"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
if has('mouse')
  set mouse=a
endif

" Display line numbers on the left
set number

" Quickly time out on keycodes: wait up to 100ms after Esc for special key
set ttimeout
set ttimeoutlen=100

" Display as much as possible of the last line in a window
set display=lastline

" Display 5 lines above/below the cursor when scrolling with a mouse
set scrolloff=5

" Better horizontal scrolling
set sidescroll=1
set sidescrolloff=5

" Display different types of whitespaces
set list
set listchars=tab:⇥\ ,trail:•,precedes:←,extends:→,nbsp:␣

" Insert only one space after punctuation on a join
set nojoinspaces

" New splits will be at the bottom or to the right side of the screen
set splitbelow
set splitright

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**

" Set the window’s title, reflecting the file currently being edited
if has('title')
  set title
endif

" Remove a comment leader when joining lines
set formatoptions+=j

" Change cursor shape in different modes
let &t_SI = "\<Esc>[6 q"
if exists('&t_SR')
  let &t_SR = "\<Esc>[4 q"
endif
let &t_EI = "\<Esc>[2 q"

" Color scheme based on https://github.com/phanviet/vim-monokai-pro
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif
set background=dark
set cursorline
highlight clear
let g:colors_name = "monokai_pro"
highlight Cursor ctermfg=236 ctermbg=231 cterm=NONE guifg=#2d2a2e guibg=#fcfcfa gui=NONE
highlight SignColumn ctermfg=NONE ctermbg=237 cterm=NONE guibg=#3a3a3a guifg=NONE guisp=NONE gui=NONE
highlight Visual ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#403e41 gui=NONE
highlight CursorLine ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
highlight CursorLineNr ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
highlight CursorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
highlight ColorColumn ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#423f42 gui=NONE
highlight LineNr ctermfg=246 ctermbg=59 cterm=NONE guifg=#959394 guibg=#423f42 gui=NONE
highlight VertSplit ctermfg=59 ctermbg=59 cterm=NONE guifg=#696769 guibg=#696769 gui=NONE
highlight MatchParen ctermfg=204 ctermbg=NONE cterm=underline guifg=#ff6188 guibg=NONE gui=underline
highlight StatusLine ctermfg=231 ctermbg=59 cterm=bold guifg=#fcfcfa guibg=#696769 gui=bold
highlight StatusLineNC ctermfg=231 ctermbg=59 cterm=NONE guifg=#fcfcfa guibg=#696769 gui=NONE
highlight Pmenu ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
highlight PmenuSel ctermfg=NONE ctermbg=59 cterm=NONE guifg=NONE guibg=#403e41 gui=NONE
highlight IncSearch ctermfg=236 ctermbg=221 cterm=NONE guifg=#2d2a2e guibg=#ffd866 gui=NONE
highlight Search ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline
highlight Directory ctermfg=209 ctermbg=NONE cterm=NONE guifg=#fc9867 guibg=NONE gui=NONE
highlight Folded ctermfg=189 ctermbg=60 cterm=NONE guifg=#d7d7ff guibg=#5f5f87 gui=NONE
highlight Normal ctermfg=231 ctermbg=236 cterm=NONE guifg=#fcfcfa guibg=#2d2a2e gui=NONE
highlight Boolean ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
highlight Character ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
highlight Comment ctermfg=59 ctermbg=NONE cterm=italic guifg=#727072 guibg=NONE gui=italic
highlight Conditional ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight Constant ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
highlight Define ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight DiffAdd ctermfg=231 ctermbg=64 cterm=bold guifg=#fcfcfa guibg=#47840e gui=bold
highlight DiffDelete ctermfg=88 ctermbg=NONE cterm=NONE guifg=#8c0809 guibg=NONE gui=NONE
highlight DiffChange ctermfg=231 ctermbg=23 cterm=NONE guifg=#fcfcfa guibg=#273a5b gui=NONE
highlight DiffText ctermfg=231 ctermbg=24 cterm=bold guifg=#fcfcfa guibg=#204a87 gui=bold
highlight ErrorMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
highlight WarningMsg ctermfg=NONE ctermbg=NONE cterm=NONE guifg=NONE guibg=NONE gui=NONE
highlight Float ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
highlight Function ctermfg=150 ctermbg=NONE cterm=NONE guifg=#a9dc76 guibg=NONE gui=NONE
highlight Identifier ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=italic
highlight Keyword ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight Label ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight NonText ctermfg=240 ctermbg=236 cterm=NONE guifg=#5b595c guibg=#2d2a2e gui=NONE
highlight Number ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
highlight Special ctermfg=147 ctermbg=NONE cterm=NONE guifg=#ab9df2 guibg=NONE gui=NONE
highlight Operator ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight PreProc ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight SpecialKey ctermfg=240 ctermbg=59 cterm=NONE guifg=#5b595c guibg=#423f42 gui=NONE
highlight Statement ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight StorageClass ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=italic
highlight String ctermfg=221 ctermbg=NONE cterm=NONE guifg=#ffd866 guibg=NONE gui=NONE
highlight Tag ctermfg=204 ctermbg=NONE cterm=NONE guifg=#ff6188 guibg=NONE gui=NONE
highlight Title ctermfg=231 ctermbg=NONE cterm=bold guifg=#fcfcfa guibg=NONE gui=bold
highlight Todo ctermfg=231 ctermbg=NONE cterm=inverse,bold guifg=#fcfcfa guibg=NONE gui=inverse,bold,italic
highlight Type ctermfg=116 ctermbg=NONE cterm=NONE guifg=#78dce8 guibg=NONE gui=italic
highlight Underlined ctermfg=NONE ctermbg=NONE cterm=underline guifg=NONE guibg=NONE gui=underline

" When editing a file, always jump to the last known cursor position.
" Don't do it when the position is invalid, when inside an event handler
" (happens when dropping a file on gvim) and for a commit message (it's
" likely a different one than last time).
if has('eval')
  autocmd vimStartup BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis | wincmd p | diffthis
endif

" Prevent that the langmap option applies to characters that result from a
" mapping.  If set (default), this may break plugins (but it's backward
" compatible).
if has('langmap') && exists('+langremap')
  set nolangremap
endif

" Persistent undo
if has('persistent_undo')
  set undofile
  if !isdirectory(expand("$HOME/.vim/undo"))
    call mkdir(expand("$HOME/.vim/undo"), "p")
  endif
  set undodir=$HOME/.vim/undo
  autocmd vimStartup BufWritePre /tmp/* setlocal noundofile
endif

" Extended "%" matching
runtime macros/matchit.vim

" Make :grep call ripgrep
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

" Open the quickfix window whenever a quickfix command (e.g., :make) is executed
" and there are valid errors to display.
autocmd vimStartup QuickFixCmdPost [^l]* cwindow


"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Do smart autoindenting when starting a new line.
set smartindent

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=2
set softtabstop=2
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4

" Align indent to next multiple value of shiftwidth.
set shiftround


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-l> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <silent> <C-l> :<C-u>nohlsearch<CR><C-l>

" Map the leader key to a spacebar
let mapleader = "\<Space>"

" Traverse the buffer list
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> ]B :blast<CR>

" Navigation in the location and quickfix list
nnoremap <silent> [l :lprevious<CR>zv
nnoremap <silent> ]l :lnext<CR>zv
nnoremap <silent> [L :lfirst<CR>zv
nnoremap <silent> ]L :llast<CR>zv
nnoremap <silent> [q :cprevious<CR>zv
nnoremap <silent> ]q :cnext<CR>zv
nnoremap <silent> [Q :cfirst<CR>zv
nnoremap <silent> ]Q :clast<CR>zv

" Expand to the path of the active buffer
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Preserve flags when repeating the last substitution
nnoremap & :&&<CR>
xnoremap & :&&<CR>

" Visual star
xnoremap * :<C-u>call <SID>VSetSearch('/')<CR>/<C-R>=@/<CR><CR>
xnoremap # :<C-u>call <SID>VSetSearch('?')<CR>?<C-R>=@/<CR><CR>
function! s:VSetSearch(cmdtype)
  let temp = @s
  normal! gv"sy
  let @/ = '\V' . substitute(escape(@s, a:cmdtype.'\'), '\n', '\\n', 'g')
  let @s = temp
endfunction

" Shifting does not exit visual mode
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection
vnoremap . :normal .<CR>

" thef*ck
cabbrev w!! w !sudo tee % > /dev/null


"------------------------------------------------------------
" Status line {{{1
"

" Always display the status line, even if only one window is displayed
set laststatus=2

let g:currentmode={
  \ 'n'      : 'Normal',
  \ 'v'      : 'Visual',
  \ 'V'      : 'V·Line',
  \ "\<C-v>" : 'V·Block',
  \ 's'      : 'Select',
  \ 'S'      : 'S·Line',
  \ "\<C-s>" : 'S·Block',
  \ 'i'      : 'Insert',
  \ 'R'      : 'Replace',
  \ 'c'      : 'Command',
  \ 'r'      : 'Prompt',
  \ '!'      : 'Shell',
  \ 't'      : 'Terminal'
  \ }

set noshowmode
set statusline=
set statusline+=%*\ %{toupper(g:currentmode[mode()])}\   " The current mode
set statusline+=%1*                                     " Separator
set statusline+=%2*\ %<%F%m%w\                           " File path, modified, preview
set statusline+=%{&readonly?'\ ':''}                    " Readonly
set statusline+=%3*                                     " Separator
set statusline+=%4*\ %{&filetype}                        " FileType
set statusline+=%=                                       " Right Side
set statusline+=%4*%{&paste?'paste\ \ ':''}             " Paste
set statusline+=%{&fenc!=''?&fenc:&enc}\                 " Encoding
set statusline+=(%{&fileformat})\                        " FileFormat (dos/unix..)
set statusline+=%3*                                     " Separator
set statusline+=%2*\ %l:%v\ (%p%%)\                      " Line number / total lines, percentage of document
set statusline+=%1*                                     " Separator
set statusline+=%*\ %n\                                  " Buffer number

highlight User1 ctermfg=59 ctermbg=238 cterm=bold guifg=#696769 guibg=#423f42 gui=bold
highlight User2 ctermfg=231 ctermbg=238 cterm=bold guifg=#fcfcfa guibg=#423f42 gui=bold
highlight User3 ctermfg=238 ctermbg=234 cterm=bold guifg=#423f42 guibg=#181819 gui=bold
highlight User4 ctermfg=231 ctermbg=234 cterm=bold,italic guifg=#fcfcfa guibg=#181819 gui=bold,italic

autocmd vimStartup InsertEnter * highlight StatusLine ctermfg=231 ctermbg=24 cterm=bold guifg=#fcfcfa guibg=#204a87 gui=bold | highlight User1 ctermfg=24 ctermbg=238 cterm=bold guifg=#204a87 guibg=#423f42 gui=bold
autocmd vimStartup InsertLeave * highlight StatusLine ctermfg=231 ctermbg=59 cterm=bold guifg=#fcfcfa guibg=#696769 gui=bold | highlight User1 ctermfg=59 ctermbg=238 cterm=bold guifg=#696769 guibg=#423f42 gui=bold


"------------------------------------------------------------
