set nocompatible " dont'w worry about vi compatibility
set hidden " don't delete buffers when unfocused
let mapleader = "," " use , as shortcut char for custom bindings
set ignorecase
set smartcase " case insensitive search if all chars are lower case
set scrolloff=3 " keep 3 rows of context above and below cursor
set cmdheight=1 " make the command area just one line high

call pathogen#infect()

filetype on
filetype plugin on " auto detect type of file being edited
filetype indent on " auto indent plugin

set history=1000 " number of commands and search patterns to save
set shiftround " align to standard indent when shifting with < and >

set textwidth=80
set formatoptions+=r " auto-format comments while typing
set formatoptions+=c " word-wrap comments
set formatoptions-=t " don't word wrap most text

" Match trailing whitespace and long columns. This must appear before the first
" colorscheme command.
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/ " highlight trailing whitespace
match ExtraWhitespace '\%>80v.\+'

syntax on " use syntax color highlighting
set background=dark
colorscheme solarized
set t_Co=16

set mouse=a " enable VIM mouse
set ttyfast " smoother display on fast network connections
set whichwrap=b,s,<,>,[,],~ " allow most motion keys to wrap
set backspace=indent,eol,start " allow bs over EOL, indent, and start of insert
set incsearch " incremental search
set nojoinspaces " use only one space when using join
set matchpairs+=<:> " add < > to chars that form pairs (see % command)
set showmatch " show matching brackets by flickering cursor
set matchtime=1 " show matching brackets quicker than default
set autoread " automatically read file changed outside of Vim
set autowrite " automatically save before commands like :next and :make
set splitbelow " open new split windows below the current one
set winminheight=0 " Allow only the status bar of a window to be shown
set noequalalways " do not resize windows on split/close
set showcmd " show partial command in status line
set encoding=utf-8

set suffixes+=.class,.pyc,.o " skip bytecode files for filename completion
set suffixes-=.h " do not skip C header files for filename completion

set wrap " wrap long lines

set backup " backup files before editing
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set virtualedit=block " allow Visual mode to select where there aren't chars
set laststatus=2 " always show statusline
" set statusline=%n\ %1*%h%f%*\ %=%<[%3lL,%2cC]\ %2p%%\ 0x%02B%r%m
let g:Powerline_symbols = 'fancy' " use fancy unicode powerline
set ruler " show ruler, but only shown if laststatus is off
set rulerformat=%h%r%m%=%f " sane value in case laststatus is off
" scroll viewport a bit faster than usual
nnoremap <C-e> 4<C-e>
nnoremap <C-y> 4<C-y>

set nonumber " don't show line numbers by default
set printoptions=number:y " put line numbers on hardcopy

set wildmenu " show a menu of matches when doing completion
set wildmode=list:longest

set hlsearch " highlight the current search pattern
" in normal mode enter clears search highlight
nnoremap <silent><CR> :nohlsearch<CR><CR>

set title " shows the current filename and path in the term title.
set numberwidth=3 " minimum width of line numbers (default is 8)

" tab settings
set tabstop=2
set sts=2
set shiftwidth=2
set smarttab
set expandtab

" indent settings
set autoindent
set smartindent

" maps

" This keeps the visual selection active after indenting.
" Usually the visual selection is lost after you indent it.
vmap > >gv
vmap < <gv

" spell check
" <F2> or \s
map <silent><F2> <ESC>:set spell!<CR>
"setlocal spell spelllang=en_us

" redraw window
" <F5>
map <silent><F5> :redraw!<CR>

" yank all lines
map <silent><leader>a gg"+yG

" toggle line numbers
map <silent><leader>n :set number!<CR>

" plugins
runtime ftplugin/man.vim " allow vim to read man pages
runtime macros/matchit.vim " match more things (like if/then/endif)

" jump to the last known position in a file
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g'\"" | endif

" HAML/Sass language definition
au BufRead,BufNewFile *.sass set filetype=sass
au! Syntax newlang source ~/.vim/syntax/sass.vim

" FuzzyFinder and FuzzyFinderTextmate
let g:fuzzy_ignore = "*.log"
let g:fuzzy_matching_limit = 70
map <leader>t :FuzzyFinderTextMate<CR>
map <leader>b :FuzzyFinderBuffer<CR>

" Scratch buffer
function! ToggleScratch()
  if expand('%') == g:ScratchBufferName
    quit
  else
    Sscratch
  endif
endfunction
map <leader>s :call ToggleScratch()<CR>

" ` (jump row+col) is more useful than '(jump col), so swap them
nnoremap ' `
nnoremap ` '

" Haskell
au Bufenter *.hs compiler ghc
let g:haddock_browser = "/usr/bin/google-chrome"

set viminfo=!,%,'20,/100,:100,s100,n~/.viminfo " options for .viminfo

" Go has its own style ...
autocmd FileType go setlocal noet ci pi sts=8 sw=8 ts=8
set rtp+=$GOROOT/misc/vim
