" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

au!

" Automatically re-source .vimrc on save
au BufWritePost .vimrc source ~/.vimrc

" Attempt to determine the type of a file based on its name and possibly its
" contents.  Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.

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

" Quickly time out on keycodes, but never time out on mappings
" set notimeout ttimeout ttimeoutlen=200
set timeoutlen=400 ttimeoutlen=400

" New leader
let mapleader=';'

" Since I always accidentally hit this
noremap <F1> <nop>
inoremap <F1> <nop>
unmap <F1>
iunmap <F1>

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

" Movement is visual
map j gj
map k gk

" quick-saving/quitting
noremap <Leader>w :w<CR>
inoremap <Leader>w <Esc>:w<CR>a
noremap <Leader>q :q<CR>
inoremap <Leader>q <Esc>:q<CR>a
noremap <Leader>qa :qa<CR>
inoremap <Leader>qa <Esc>:qa<CR>
noremap <Leader>d :bd<CR>
inoremap <Leader>d <Esc>:bd<CR>a
noremap <Leader>l :nohl<CR><C-L>
inoremap <Leader>l <Esc>:nohl<CR><C-L>a

" Buffer navigation
noremap <Leader>k :bn<CR>
inoremap <Leader>k <Esc>:bn<CR>a
noremap <Leader>j :bp<CR>
inoremap <Leader>j <Esc>:bp<CR>a

" quick formatting
nnoremap <Leader>f {gq}

" 256 colors
" set t_Co=256

"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.

" Indentation settings for using 2 spaces instead of tabs.
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

"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings

" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$

" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

map ~ :NERDTreeToggle<CR>

let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1

"------------------------------------------------------------

" Highlight trailing whitespace
highlight eolWS ctermbg=Red guibg=Red
match eolWS /\s\+$/
autocmd BufWinEnter * match eolWS /\s\+$/
autocmd InsertEnter * match eolWS /\s\+\%#\#<!$/
autocmd InsertLeave * match eolWS /\s\+$/
autocmd BufWinLeave * call clearmatches()

au BufEnter *.tex setl tw=70

" System clipboard!
set clipboard=unnamed

au BufNewFile,BufRead *.hpp,*.cpp set syntax=cpp11 ft=cpp11 cindent
au BufNewFile,BufRead *.h,*.c,*.hpp,*.cpp call setCBuild()

noremap <Leader>m :! ~/.vim/build.sh "%"<CR>
inoremap <Leader>m <Esc>:! ~/.vim/build.sh "%"<CR>a
noremap <Leader>r :! ~/.vim/build.sh "%" r<CR>
inoremap <Leader>r <Esc>:! ~/.vim/build.sh "%" r<CR>a

execute pathogen#infect()

colorscheme Dim

set nocursorline

let g:lightline = {
      \ 'colorscheme':'wombat',
      \ }
