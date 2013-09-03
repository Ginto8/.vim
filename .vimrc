" .vimrc of Joe Doyle (Ginto8)

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

au!

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'MyFugitive',
      \   'readonly': 'MyReadonly',
      \   'modified': 'MyModified'
      \ }
      \ }

function! MyModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! MyReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "x"
  else
    return ""
  endif
endfunction

function! MyFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

execute pathogen#infect()

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


" One of the most important options to activate. Allows you to switch from an
" unsaved buffer without saving it first. Also allows you to keep an undo
" history for multiple files. Vim will complain if you try to quit without
" saving, and swap files will keep you safe if your computer crashes.
set hidden

" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window for multiple buffers, and/or:
" set confirm
" set autowriteall

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Modelines have historically been a source of security vulnerabilities.  As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Use sane regexes
nnoremap / /\v
vnoremap / /\v

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell.  If visualbell is set, and
" this line is also included, vim will neither flash nor beep.  If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
"set cmdheight=2

" Display line numbers on the left
set number

set timeout ttimeout
set timeoutlen=400 ttimeoutlen=400

" New leader
let mapleader=';'

" Since I always accidentally hit this
noremap <F1> <nop>
inoremap <F1> <nop>

" Use <F1> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F1>

" Leave paste mode when you leave insert mode
au InsertLeave * set nopaste

" Better escape
inoremap <Leader>n <Esc>
noremap <Leader>n <Esc>

" Unlimited tabbing
vnoremap > >gv
vnoremap < <gv

" Redos!
noremap U <C-R>

" Beginning/End of line with home row
noremap H ^
noremap L $

" Insert mode home-row movement
imap <C-h> <C-o>h
imap <C-j> <C-o>j
imap <C-k> <C-o>k
imap <C-l> <C-o>l

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Movement is visual
map j gj
map k gk

" quick-saving/quitting
noremap <Leader>w :w<CR>
inoremap <Leader>w <Esc>:w<CR>a
noremap <Leader>wa :wa<CR>
inoremap <Leader>wa <Esc>:wa<CR>a
noremap <Leader>q :q<CR>
inoremap <Leader>q <Esc>:q<CR>a
noremap <Leader>qa :qa<CR>
inoremap <Leader>qa <Esc>:qa<CR>
noremap <Leader>wq :wq<CR>
inoremap <Leader>wq <Esc>:wq<CR>a
noremap <Leader>wqa :wqa<CR>
inoremap <Leader>wqa <Esc>:wqa<CR>a
noremap <Leader>d :bd<CR>
inoremap <Leader>d <Esc>:bd<CR>a
noremap <Leader>l :nohl<CR><C-L>
inoremap <Leader>l <Esc>:nohl<CR><C-L>a
noremap <Leader>t :clo<CR>
inoremap <Leader>t <Esc>:clo<CR>a

" Buffer navigation
noremap <Leader>k :bn<CR>
inoremap <Leader>k <Esc>:bn<CR>a
noremap <Leader>j :bp<CR>
inoremap <Leader>j <Esc>:bp<CR>a

" quick formatting
nnoremap <Leader>f {gq}

" 256 colors
" set t_Co=256

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab

" Indentation settings for using hard tabs for indent. Display tabs as
" two characters wide.
"set shiftwidth=2
"set tabstop=2

" Word count, TeX and non
noremap <Leader>tc :! detex % \| wc -w<CR>
noremap <Leader>c :! wc -w %<CR>

" Switch header/source
noremap <Leader>a :A<CR>
inoremap <Leader>a <Esc>:A<CR>a

" fugitive mappings
noremap <Leader>gs :Gstatus<CR>
inoremap <Leader>gs <Esc>:Gstatus<CR>a
noremap <Leader>gc :Gcommit<CR>
inoremap <Leader>gc <Esc>:Gcommit<CR>a
noremap <Leader>gw :Gwrite<CR>
inoremap <Leader>gw <Esc>:Gwrite<CR>a
noremap <Leader>gr :Gremove<CR>
inoremap <Leader>gr <Esc>:Gremove<CR>a
noremap <Leader>gk :! (cd "$(dirname %)";gitk)<CR>
inoremap <Leader>gk <Esc>:! (cd "$(dirname %)";gitk)<CR>a

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
" nnoremap <C-L> :nohl<CR><C-L>

map ~ :NERDTreeToggle<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

" Highlight trailing whitespace
highlight eolWS ctermbg=Red guibg=Red
match eolWS /\s\+$/
autocmd BufWinEnter * match eolWS /\s\+$/
autocmd InsertEnter * match eolWS /\s\+\%#\#<!$/
autocmd InsertLeave * match eolWS /\s\+$/
autocmd BufWinLeave * call clearmatches()

au BufEnter *.tex setl tw=70

" System clipboard!
" set clipboard=unnamed
noremap <Leader>p "*p
inoremap <Leader>p <Esc>"*pa
noremap <Leader>P "*P
inoremap <Leader>P <Esc>"*Pa

au BufNewFile,BufRead *.hpp,*.cpp set syntax=cpp11 ft=cpp11 cindent

noremap <Leader>m :! ~/.vim/build.sh "%"<CR>
inoremap <Leader>m <Esc>:! ~/.vim/build.sh "%"<CR>a
noremap <Leader>r :! ~/.vim/build.sh "%" r<CR>
inoremap <Leader>r <Esc>:! ~/.vim/build.sh "%" r<CR>a

" Automatic brackets
inoremap {<CR> {<CR>}<Esc>O

colorscheme Dim

set nocursorline

" Automatically re-source .vimrc on save
au BufWritePost .vimrc so ~/.vimrc
" Hack to prevent the above autocmd from fucking up lightline
if exists('g:resourced')
    execute lightline#colorscheme()
endif
let g:resourced=1

" make <CR> in normal mode behave the way I expect it to
au BufNewFile,BufRead * map <CR> j
