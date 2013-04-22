syntax on
set autoread
set nocompatible
set nowrap

set backspace=2 " make backspace work like most other apps

"<====Vundler=====
filetype off " required!
set rtp+=~/.vim/vundle.git/ 
call vundle#rc()

Bundle 'wombat256.vim'
set t_Co=256
colorscheme wombat256mod
hi SignColumn ctermbg=none guibg=none

"Bundle 'PSearch'
"Bundle 'wikitopian/hardmode'
Bundle 'ag.vim'
Bundle 'ArnisL/grepqf.vim'
Bundle 'tyru/current-func-info.vim'

Bundle 'matchit.zip'
Bundle 'tpope/vim-speeddating'

Bundle 'ExplainPattern'
Bundle 'vim-multiedit'
Bundle 'ervandew/screen'
Bundle 'tomtom/quickfixsigns_vim'
Bundle 'kien/ctrlp.vim'
" Upgrade CtrlP
let ctrlp_filter_greps = "".
    \ "egrep -iv '\\.(" .
    \ "jar|class|swp|swo|log|so|o|pyc|jpe?g|png|gif|mo|po" .
    \ ")$' | " .
    \ "egrep -v '^(\\./)?(" .
    \ "tmp/|deploy/|classes/|libs/|deploy/vendor/|.git/|.hg/|.svn/|.*migrations/" .
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
nnoremap <c-\><Leader> :CtrlPModified<CR>
Bundle 'ctrlp-modified.vim'

Bundle 'Lokaltog/vim-easymotion'
Bundle 'LustyJuggler'
Bundle 'Lokaltog/vim-powerline'
Bundle 'tpope/vim-repeat'

Bundle 'int3/vim-extradite'

Bundle 'tpope/vim-surround'
Bundle 'Syntastic'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-endwise'
Bundle 'Tabular'
Bundle 'vimwiki'
Bundle 'mileszs/ack.vim'
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" nnoremap <Leader>s viwy:Ack<Space><C-r>"<Cr>

Bundle 'The-NERD-tree'
nmap <A-L> :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTree<CR>
nnoremap <Leader>cn :NERDTreeClose<CR>

" throws exception: easytree needs vim 7.3 with atleast 569 patchset included
" Bundle 'easytree.vim'

Bundle 'nviennot/vim-config'

" Bundle 'session.vim'
" Bundle 'xolox/vim-session'

" Conflicts with nerdtree. Not too useful anyway
" Bundle 'vim-signature'

Bundle 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

Bundle 'vim-g'
Bundle 'mattn/pastebin-vim'
source ~/.set_pastebin_key.vim

"===NEOCOMPLCACHE
Bundle 'Shougo/neocomplcache'
" Bundle 'Shougo/neocomplcache-snippets-complete'
Bundle 'ujihisa/neco-ruby'

let g:neocomplcache_enable_at_startup = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_enable_auto_select = 1
let g:neocomplcache_enable_fuzzy_completion = 1
let g:neocomplcache_fuzzy_completion_start_length = 1

" Recommended key-mappings.
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-f>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
"===NEOCOMPLCACHE

Bundle 'kchmck/vim-coffee-script'
Bundle 'mintplant/vim-literate-coffeescript'
Bundle 'tpope/vim-markdown'
Bundle 'nono/vim-handlebars'

Bundle 'groenewege/vim-less'


au BufNewFile,BufRead *.handlebars,*.hbs,*.html set ft=html syntax=handlebars
"au BufNewFile,BufRead *.coffee.md set ft=litcoffee syntax=litcoffee
filetype plugin indent on     " required!

"=====Vundler====>


" set tab to 2 spaces
set softtabstop=2
set shiftwidth=2
set tabstop=2
set expandtab

"let mapleader = ","

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
inoremap j( ()<Left>
inoremap j[ []<Left>
inoremap j" ""<Left>
inoremap kj. k_

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

" Quickly open .vimrc file
nnoremap <Leader>vv :e $MYVIMRC<CR>

" Reformat and Tidy XML Files
nnoremap <Leader>rx :silent 1,$!xmllint --format --recover - 2>/dev/null<cr>
vnoremap <Leader>rx d:vnew<CR>pggdd:silent 1,$!xmllint --format --recover - 2>/dev/null<cr>dG:q!<CR>mmP`m

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

" fix damn search
set ignorecase
set smartcase
set incsearch

" color current line background dark green
hi Cursorline ctermbg=0

" Only have cursorline in current window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

" ZMEP project specific short-cuts
nnoremap <Leader>rl :e log/development.log<CR>
nnoremap <Leader>cl :!/bin/echo "" > log/development.log<CR>

nnoremap <Leader>t :tabe<CR>
nnoremap <Leader>ct :tabc<CR>
nnoremap <Leader>tw :tabe<CR>:VimwikiIndex<CR>
nnoremap <Leader>fc :%s/Å¡/š/g<CR>:%s/Ä/ā/g<CR>:%s/Ä«/ī/g<CR>:%s/Å«/ū/g<CR>:%s/Ä/ē/g<CR>:%s/Å/ņ/g<CR>

nnoremap <Leader>yp :let @+ = expand("%")<CR>


"============>Screen commands
" TODO: save rspec cmd for 're-run' command
" Attach to screen
map <Leader>`a :ScreenShellAttach<CR>
" RSpec line
map <Leader>`` :w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
imap <Leader>`` <ESC>:w<CR> :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
" RSpec file
map <Leader>`g :w<CR> :call ScreenShellSend("rspec --fail-fast ".@%)<CR>
" RSpec file
"map <Leader>`ga :w<CR> :call ScreenShellSend("rspec ".@%)<CR>
" RSpec everything
map <Leader>`r :call ScreenShellSend("bundle exec rspec")<CR>
" Rails console test
map <Leader>`c :call ScreenShellSend("rails c test")<CR>\`toffarl\`\
" Send exit
map <Leader>`x :call ScreenShellSend("exit")<CR>
" Send clear
map <Leader>`<Leader> :call ScreenShellSend("")<CR>
" Send selected text
 vnoremap <Leader>`s y:call ScreenShellSend("<C-R>"")<CR>
" Multi-line send
vnoremap <Leader>`ms :s/\n/\\n<CR>Vy:call ScreenShellSend("<C-R>"")<CR>u<Space>:nohlsearch<Bar>:echo<CR>
" Turn off ActiveRecord::Base logging
map <Leader>`toffarl :call ScreenShellSend("ActiveRecord::Base.logger.level=10")<CR>
map <Leader>`tonarl :call ScreenShellSend("ActiveRecord::Base.logger.level=0")<CR>
" Restart damn test console
map <Leader>`rc :call ScreenShellSend("!!!")<CR>\`c

" RSpec from failed test line
map <Leader>`1 ^fsy2t::call ScreenShellSend("rspec <C-R>"")<CR>
" Cant specify line when using Zeus :*(
" map <Leader><Leader>` :w<CR> :call ScreenShellSend("zeus rspec ".@% . ':' . line('.'))<CR>
" Reload source file
map <Leader>`l :w<CR>:call ScreenShellSend("load '".@%."';")<CR>
imap <Leader>`l <ESC>:w<CR>:call ScreenShellSend("load '".@%."';")<CR>
" Pry whereami?
map <Leader>`= :call ScreenShellSend("whereami")<CR>
" Send next
map <Leader>`n :call ScreenShellSend("next")<CR>
" Send q
map <Leader>`q :call ScreenShellSend("q")<CR>
" Switch to development environment
map <Leader>`d :call ScreenShellSend("env development")<CR>

imap kjs <ESC>:call ScreenShellSend("<C-r>.")<CR>
imap kjsu <ESC>:call ScreenShellSend("<C-r>.")<CR>u
imap kj` <ESC>:w<CR>\``
" :call ScreenShellSend("rspec ".@% . ':' . line('.'))<CR>
" TODO: up <cr>
"map <Leader>`k <ESC>:call ScreenShellSend("<Up>

" ==>Breakpoints
" Delete all
nnoremap <Leader>`db :call ScreenShellSend("break --delete-all")<CR>
" List
nnoremap <Leader>`b :call ScreenShellSend("breakpoints")<CR>
map <Leader>`ab :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>
" <""
"<============Screen commands
nnoremap <Leader>ssx :set syntax=xml<CR>
nnoremap <Leader>ssr :set syntax=ruby<CR>
nnoremap <Leader>ssn :set syntax=none<CR>


imap kjw <ESC>:w<CR>


" Folding
map <Leader>sfs :set fdm=syntax<CR>
map <Leader>sfm :set fdm=manual<CR>
map <Leader>sfi :set fdm=indent<CR>
" set foldcolumn=1
" set fdm=syntax
hi FoldColumn ctermbg=none ctermfg=darkgrey
hi Folded ctermbg=none ctermfg=darkgrey

hi Search cterm=NONE ctermfg=black ctermbg=yellow
" map <C-l> :cclose<CR>
" autocmd VimEnter,BufNewFile,BufReadPost * silent! call HardMode()
hi String		ctermfg=118		cterm=none		guifg=#95e454	gui=italic
hi Directory ctermfg=118


map <Leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

hi VimwikiLink ctermfg=190
hi rubyTodo ctermfg=black ctermbg=190
hi Search ctermfg=black ctermbg=190
nmap > ]qzz
nmap < [qzz
nmap n nzz
nmap N Nzz
" autocmd BufReadPost quickfix set modifiable





" -------------> multiline
" Insert a disposable marker after the cursor
nmap <leader>ma :MultieditAddMark a<CR>

" Insert a disposable marker before the cursor
nmap <leader>mi :MultieditAddMark i<CR>

" Make a new line and insert a marker
nmap <leader>mo o<Esc>:MultieditAddMark i<CR>
nmap <leader>mO O<Esc>:MultieditAddMark i<CR>

" Insert a marker at the end/start of a line
nmap <leader>mA $:MultieditAddMark a<CR>
nmap <leader>mI ^:MultieditAddMark i<CR>

" Make the current selection/word an edit region
vmap <leader>m :MultieditAddRegion<CR>  
nmap <leader>mm viw:MultieditAddRegion<CR>

" Restore the regions from a previous edit session
nmap <leader>mu :MultieditRestore<CR>

" Move cursor between regions n times
map ]m :MultieditHop 1<CR>
map [m :MultieditHop -1<CR>

" Start editing!
nmap <leader>M :Multiedit<CR>

" Clear the word and start editing
nmap <leader>C :Multiedit!<CR>

" Unset the region under the cursor
nmap <silent> <leader>md :MultieditClear<CR>

" Unset all regions
nmap <silent> <leader>mr :MultieditReset<CR>
" <------------- multiline
