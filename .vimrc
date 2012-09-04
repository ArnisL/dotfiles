set nocompatible
set nowrap

"<====Vundler=====
filetype off " required!
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

Bundle 'kien/ctrlp.vim'
" Upgrade CtrlP
let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "deploy/|lib/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/" .
    \ ")'"
 
let my_ctrlp_git_command = "" .
    \ "cd %s && git ls-files | " .
    \ ctrlp_filter_greps
 
if has("unix")
    let my_ctrlp_user_command = "" .
    \ "find %s '(' -type f -or -type l ')' -maxdepth 15 -not -path '*/\\.*/*' | " .
    \ ctrlp_filter_greps
endif
let g:ctrlp_user_command = ['.git/', my_ctrlp_git_command, my_ctrlp_user_command]
nnoremap <c-\> :CtrlP<CR>

Bundle 'Lokaltog/vim-easymotion'
Bundle 'LustyJuggler'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-repeat'
Bundle 'extradite.vim'
Bundle 'tpope/vim-surround'
Bundle 'Syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-endwise'
Bundle 'Tabular'
Bundle 'vimwiki'
Bundle 'mileszs/ack.vim'
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nnoremap <Leader>s viwy:Ack<Space><C-r>"<Cr>

Bundle 'wombat256.vim'
colorscheme wombat256mod
Bundle 'ZoomWin'

Bundle 'The-NERD-tree'
nmap <A-L> :NERDTreeFind<CR>

Bundle 'TaskList.vim'

" Bundle 'session.vim'
Bundle 'xolox/vim-session'

Bundle 'taglist.vim'

" Conflicts with nerdtree. Not too useful anyway
" Bundle 'vim-signature'

filetype plugin indent on     " required!
"=====Vundler====>


" set tab to 2 spaces
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

" show line numbers
set nu

" turn on indentation, set smartindent
set autoindent

" rspec create context
inoremap \rc context "" do<Cr>end<Up><Right><Right><Right><Right><Right><Right>
inoremap \ri it "" do<Cr>end<Up><Right>
inoremap \rb before {  }<Left><Left>
inoremap \rlb before doend<Left><Left><Left><Cr><Cr><Up><Space><Space>

inoremap j{ <Space>{<Space><Space>}<Left><Left>
inoremap jl =
inoremap jjl <Space>=<Space>
inoremap j. _
inoremap kj <Esc>
inoremap j; :<Space>

cnoremap jl =
cnoremap jjl <Space>=<Space>
cnoremap j. _
cnoremap kj <Esc>
cnoremap j; :<Space>

set hlsearch
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>

" reselect on indent
vnoremap < <gv
vnoremap > >gv

"au BufLeave,FocusLost * silent! :wa
"set autowriteall

" map escape sequences to their alt combos
" http://stackoverflow.com/a/10216459/82062
let c='A'
while c <= 'Z'
  exec "set <A-".c.">=\e".c
  exec "imap \e".c." <A-".c.">"
  let c = nr2char(1+char2nr(c))
endw
set timeout ttimeoutlen=50

" add syntax highlighting for RSpec
autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
highlight def link rubyRspec Function

" Easy split navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Improve up/down movement on wrapped lines
nnoremap j gj
nnoremap k gk

" Automatically reload vimrc when it's saved
augroup AutoReloadVimRC
  au!
  au BufWritePost $MYVIMRC so $MYVIMRC
augroup END

" Map Q to repeat the last recorded macro
map Q @@

" Toggle invisibles
" noremap <Leader>i :set list!<CR>
" set listchars=eol:¬

" Drag Current Line/s Vertically
noremap <A-j> :m+<CR>
noremap <A-k> :m-2<CR>
inoremap <A-j> <Esc>:m+<CR>
inoremap <A-k> <Esc>:m-2<CR>
vnoremap <A-j> :m'>+<CR>gv
vnoremap <A-k> :m-2<CR>gv

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Only have cursorline in current window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" Quickly open .vimrc file
nnoremap <Leader>vv :e $MYVIMRC<CR>

" Reformat and Tidy XML Files
nnoremap <Leader>rx :silent 1,$!xmllint --format --recover - 2>/dev/null<cr>

" Fugitive shortcuts
nnoremap <Leader>gr :Gread<CR>
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gc :Gcommit<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gw :Gwrite<CR>
nnoremap <Leader>g> :Git push origin master<CR>
nnoremap <Leader>g< :Git stash<CR>:Git pull --rebase<CR>:Git stash pop<CR>
nnoremap <Leader>gs> :Git stash<CR>
nnoremap <Leader>gs< :Git stash pop<CR>
nnoremap <Leader>gl :Glog<CR>

" Save your swp files to a less annoying place than the current directory.
" If you have .vim-swap in the current directory, it'll use that.
" Otherwise it saves it to ~/.vim/swap, ~/tmp or .
if isdirectory($HOME . '/.vim/swap') == 0
  :silent !mkdir -p ~/.vim/swap >/dev/null 2>&1
endif
set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

:nnoremap <Leader>it "=strftime("[%H:%M] ")<CR>P
:nnoremap <Leader>id "=strftime("%a %d, %b %Y ")<CR>P

" Fold shit above & below
:vnoremap <Leader>za <Esc>`<kzfgg`>jzfG`<

vnoremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

" :foo => :bar ==========> foo: :bar
noremap <Leader>r=>: :s/:\(\S*\) =>/\1:/g<CR>
