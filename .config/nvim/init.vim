set backspace=2
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab
set nu
set autoindent

" https://vi.stackexchange.com/questions/10382/strange-behavior-between-autochdir-and-netrw
" set autochdir

set sessionoptions+=folds

set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=1000
set undoreload=10000

set termguicolors
hi Search ctermfg=black ctermbg=yellow
syntax enable
colorscheme blue

" Open netrw splits to the right
let g:netrw_altv=1

imap kj <ESC>:w<CR>
map <MiddleMouse> :E<CR>
map <RightMouse> <Nop>

call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'elmindreda/vimcolors'
Plug 'keith/rspec.vim'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-cucumber'
call plug#end()

" colorscheme nord
colorscheme phosphor
hi TabLine guibg=#001000
hi TabLine guifg=gray
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
hi Folded guibg=none
