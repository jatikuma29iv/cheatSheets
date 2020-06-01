"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
"                       __   _ _ _ __ ___  _ __ ___                            "
"                       \ \ / / | '_ ` _ \| '__/ __|                           "
"                        \ V /| | | | | | | | | (__                            "
"                         \_/ |_|_| |_| |_|_|  \___|                           "
"                                                                              "
"++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
let $vimhome=fnamemodify(resolve(expand("~/.vimrc")), ':p:h')
let $vundle=$vimhome."/.vim/bundle/Vundle.vim"

syntax on
set nocompatible              " be iMproved, required

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"> Vundle Setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype off                  " required
set rtp+=$vundle              " set the runtime path to include Vundle and initialize
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim' " let Vundle manage Vundle, required
  "-------------------=== Code/Project navigation ===-------------
  Plugin 'scrooloose/nerdtree'                " added nerdtree
  Bundle 'jistr/vim-nerdtree-tabs'
  Plugin 'majutsushi/tagbar'                  " Class/module browser
  Plugin 'kien/ctrlp.vim'                     " Fast transitions on project files
  "-------------------=== Other ===-------------------------------
  Plugin 'bling/vim-airline'                  " Lean & mean status/tabline for vim
  Plugin 'vim-airline/vim-airline-themes'     " Themes for airline
  Plugin 'Lokaltog/powerline'                 " Powerline fonts plugin
  Plugin 'fisadev/FixedTaskList.vim'          " Pending tasks list
  Plugin 'rosenfeld/conque-term'              " Consoles as buffers
  Plugin 'tpope/vim-surround'                 " Parentheses, brackets, quotes, XML tags, and more
  "Plugin 'flazz/vim-colorschemes'             " Colorschemes
  Plugin 'jreybert/vimagit'                   " git integration
  "-------------------=== Languages support ===-------------------
  "-------------------=== Markdown ===-------------
  Plugin 'mzlogin/vim-markdown-toc' " markdown TOC plugin
  "-------------------=== javascript ===-------------
  " Syntax for JavaScript libraries," including Angular. This is the hotness you
  " want to autocomplete ng-repeat et al. in your html.
  Plugin 'othree/javascript-libraries-syntax.vim'
  Plugin 'leafgarland/typescript-vim'         " typescript
  Plugin 'burnettk/vim-angular'               " added Angular 5 syntax highlighter
  Plugin 'pedrohdz/vim-yaml-folds'            " yaml folding
" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype on
filetype plugin on
filetype plugin indent on    " required

"> General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set backspace config
" set backspace=eol,start,indent
set backupdir=~/.vim_bak
" set cmdheight=2 "The commandbar height
" set hid "Change buffer - without saving
set ruler "Always show current position
" set whichwrap+=<,>,h,l
set wildmenu "Turn on WiLd menu


set ls=2            " allways show status line

"-------------------=== search ===-------------
set smartcase
set hlsearch "Highlight search things
set ignorecase "Ignore case when searching
set incsearch "Make search act like search in modern browsers
set nolazyredraw "Don't redraw while executing macros 
set magic "Set magic on, for regular expressions

set showmatch "Show matching bracets when text indicator is over them
" set mat=2 "How many tenths of a second to blink

"-------------------=== no sound on error ===-------------
set noerrorbells
set novisualbell

"> Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=2       " The width of a TAB is set to 2.
" Still it is a \t. It is just that
" Vim will interpret it to be having
" a width of 2.

set shiftwidth=2    " Indents will have a width of 2
set softtabstop=2   " Sets the number of columns for a TAB
set expandtab       " Expand TABs to spaces
set lbr
" set tw=500
set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines
let g:html_indent_inctags = "html,body,head,tbody,table,tr,td"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"> Block curson
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

set fdm=indent

if &diff
    " diff mode
    set diffopt+=iwhite
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Folding
set foldmethod=indent   
set foldnestmax=10
set nofoldenable
set foldlevel=2

" cnoremap <C-a> <Home>
" cnoremap <C-e> <End>
" cnoremap <C-p> <Up>
" cnoremap <C-n> <Down>
" cnoremap <C-b> <Left>
" cnoremap <C-f> <Right>
" cnoremap <M-b> <S-Left>
" cnoremap <M-f> <S-Right>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Angular 5 syntax highlighter
let g:angular_source_directory = 'src/app'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
set rtp+=/home/linuxbrew/.linuxbrew/opt/fzf/plugin/fzf.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Powerline Settings
set guifont=Inconsolata\ for\ Powerline:h15
let g:Powerline_symbols = 'fancy'
set encoding=utf-8
set t_Co=256
set fillchars+=stl:\ ,stlnc:\
set term=xterm-256color
set termencoding=utf-8

if has("gui_running")
    let s:uname = system("uname")
    if s:uname == "Darwin\n"
        set guifont=Source\ Code\ Pro\ for\ Powerline:h15
        "colorscheme PaperColor              " set color scheme
    endif
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-airline, Colorschemes
set t_Co=256                                " set 256 colors
"colorscheme PaperColor                     " set color scheme

let g:airline_theme='molokai'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'default'
