" :source $MYVIMRC

call plug#begin()
Plug 'Badacadabra/vim-archery'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'evidens/vim-twig'
Plug 'plasticboy/vim-markdown'
Plug 'pangloss/vim-javascript'
Plug 'elzr/vim-json'
Plug 'godlygeek/tabular'
Plug 'chrisbra/Colorizer'
call plug#end()

set termguicolors

colorscheme archery
hi Normal ctermbg=none

set number

set updatetime=100

set undodir=~/.vim/undodir
set undofile
set undolevels=1000
set undoreload=10000

set backspace=2
set softtabstop=2
set tabstop=2
set shiftwidth=2
set expandtab
set nu
" set autoindent
set sessionoptions+=folds
syntax enable


let g:colorizer_auto_color = 1

hi SignColumn ctermbg=none guibg=none
hi LineNr guibg=none

hi GitGutterAdd    gui=bold guifg=#00FE00 guibg=none ctermfg=2 cterm=bold
hi GitGutterChange gui=bold guifg=#ffff00 guibg=none ctermfg=3 cterm=bold
hi GitGutterDelete gui=bold guifg=#ff2222 guibg=none ctermfg=1 cterm=bold
hi Search          gui=none guifg=black   guibg=yellow ctermbg=yellow ctermfg=black
hi MatchParen   cterm=none ctermbg=none ctermfg=yellow gui=bold guibg=none guifg=yellow
hi TabLine      cterm=none ctermfg=gray ctermbg=none gui=none guifg=none guibg=none
hi TabLineFill  cterm=none ctermfg=none ctermbg=none gui=none guifg=none guibg=none
hi TabLineSel   cterm=none ctermfg=none ctermbg=none gui=bold guifg=white guibg=none

hi Normal guibg=none
hi Folded guibg=none
hi VertSplit guibg=none
hi StatusLineNC guibg=none


:echo synIDattr(synIDtrans(synID(line("."), col("."), 1)), "fg")

cnoreabbrev GetFgColor echo synIDattr(synIDtrans(synID(line("."), 
		\ col("."), 1)), "fg")


hi Comment cterm=italic ctermfg=7 ctermbg=NONE gui=italic guifg=silver guibg=NONE
hi Special cterm=NONE ctermfg=7 ctermbg=NONE gui=NONE guifg=darkgray guibg=NONE
hi Identifier cterm=NONE ctermfg=6 ctermbg=NONE gui=NONE guifg=#006596 guibg=NONE
