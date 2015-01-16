" === Important ===
  " Necessary for true color support:
  " :h xterm-true-color
  set guicolors
  execute "set t_8f=\e[38;2;%lu;%lu;%lum"
  execute "set t_8b=\e[48;2;%lu;%lu;%lum"

  if &term =~ '^screen'
    execute "set t_kP=\e[5;*~"
    execute "set t_kN=\e[6;*~"
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
  endif

  syntax on
  set linespace=0
  set autoread
  set nocompatible
  set nowrap
  set backspace=2 " make backspace work like most other apps

  " vundler config
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'gmarik/Vundle.vim'

" === Moving around, searching and patterns ===
Plugin 'The-NERD-tree'
let g:NERDTreeWinSize=30
"let g:NERDChristmasTree=1
let g:NERDTreeMinimalUI=1
let g:NERDTreeDirArrows=1
nmap <A-L> :NERDTreeFind<CR>
nnoremap <Leader>n :NERDTreeTabsToggle<CR>
nnoremap <Leader>cn :NERDTreeClose<CR>
let NERDTreeIgnore = ['^log', '^tmp', '^script', '^doc$', '^public']

" throws exception: easytree needs vim 7.3 with atleast 569 patchset included
" Bundle 'easytree.vim'

" === Tags ===

" === Displaying text ===

" === Syntax, highlighting and spelling ===
  Plugin 'slim-template/vim-slim'
  au BufNewFile,BufRead *.slim setf slim

  filetype plugin indent on
  Plugin 'wombat256.vim'
  Plugin 'kchmck/vim-coffee-script'
  au BufNewFile,BufRead *.coffee setf coffee
  au BufNewFile,BufRead *.coffee set syntax=coffee
  Plugin 'mintplant/vim-literate-coffeescript'
  au BufNewFile,BufRead *.less set syntax=less
  Plugin 'tpope/vim-markdown'
  Plugin 'nono/vim-handlebars'

  " Lightline <<
    Plugin 'itchyny/lightline.vim'
    "\ 'colorscheme': 'wombat',
    let g:lightline = {
          \ 'active': {
          \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ], ['ctrlpmark'] ],
          \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
          \ },
          \ 'component_function': {
          \   'fugitive': 'MyFugitive',
          \   'filename': 'MyFilename',
          \   'fileformat': 'MyFileformat',
          \   'filetype': 'MyFiletype',
          \   'fileencoding': 'MyFileencoding',
          \   'mode': 'MyMode',
          \   'ctrlpmark': 'CtrlPMark',
          \ },
          \ 'component_expand': {
          \   'syntastic': 'SyntasticStatuslineFlag',
          \ },
          \ 'component_type': {
          \   'syntastic': 'error',
          \ },
          \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
          \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
          \ }

    function! MyModified()
      return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
    endfunction

    function! MyReadonly()
      return &ft !~? 'help' && &readonly ? 'RO' : ''
    endfunction

    function! MyFilename()
      let fname = expand('%:t')
      return fname == 'ControlP' ? g:lightline.ctrlp_item :
            \ fname == '__Tagbar__' ? g:lightline.fname :
            \ fname =~ '__Gundo\|NERD_tree' ? '' :
            \ &ft == 'vimfiler' ? vimfiler#get_status_string() :
            \ &ft == 'unite' ? unite#get_status_string() :
            \ &ft == 'vimshell' ? vimshell#get_status_string() :
            \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
            \ ('' != fname ? fname : '[No Name]') .
            \ ('' != MyModified() ? ' ' . MyModified() : '')
    endfunction

    function! MyFugitive()
      try
        if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
          let mark = ''  " edit here for cool mark
          let _ = fugitive#head()
          return strlen(_) ? mark._ : ''
        endif
      catch
      endtry
      return ''
    endfunction

    function! MyFileformat()
      return winwidth(0) > 70 ? &fileformat : ''
    endfunction

    function! MyFiletype()
      return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
    endfunction

    function! MyFileencoding()
      return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
    endfunction

    function! MyMode()
      let fname = expand('%:t')
      return fname == '__Tagbar__' ? 'Tagbar' :
            \ fname == 'ControlP' ? 'CtrlP' :
            \ fname == '__Gundo__' ? 'Gundo' :
            \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
            \ fname =~ 'NERD_tree' ? 'NERDTree' :
            \ &ft == 'unite' ? 'Unite' :
            \ &ft == 'vimfiler' ? 'VimFiler' :
            \ &ft == 'vimshell' ? 'VimShell' :
            \ winwidth(0) > 60 ? lightline#mode() : ''
    endfunction

    function! CtrlPMark()
      if expand('%:t') =~ 'ControlP'
        call lightline#link('iR'[g:lightline.ctrlp_regex])
        return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
              \ , g:lightline.ctrlp_next], 0)
      else
        return ''
      endif
    endfunction

    let g:ctrlp_status_func = {
      \ 'main': 'CtrlPStatusFunc_1',
      \ 'prog': 'CtrlPStatusFunc_2',
      \ }

    function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
      let g:lightline.ctrlp_regex = a:regex
      let g:lightline.ctrlp_prev = a:prev
      let g:lightline.ctrlp_item = a:item
      let g:lightline.ctrlp_next = a:next
      return lightline#statusline(0)
    endfunction

    function! CtrlPStatusFunc_2(str)
      return lightline#statusline(0)
    endfunction

    let g:tagbar_status_func = 'TagbarStatusFunc'

    function! TagbarStatusFunc(current, sort, fname, ...) abort
        let g:lightline.fname = a:fname
      return lightline#statusline(0)
    endfunction

    augroup AutoSyntastic
      autocmd!
      autocmd BufWritePost *.c,*.cpp call s:syntastic()
    augroup END
    function! s:syntastic()
      SyntasticCheck
      call lightline#update()
    endfunction

    let g:unite_force_overwrite_statusline = 0
    let g:vimfiler_force_overwrite_statusline = 0
    let g:vimshell_force_overwrite_statusline = 0

" === Multiple windows ===

" === Multiple tab pages ===
  Plugin 'Tab-Name'
  Plugin 'jistr/vim-nerdtree-tabs'

" === Terminal ===

" === Using the mouse ===

" === Printing ===

" === Messages and info ===

" === Selecting text ===

" === Editing text ===
"Plugin 'Raimondi/delimitMate'

" === Tabs and indenting ===

" === Folding ===
" Folding
map <Leader>sfs :set fdm=syntax<CR>
map <Leader>sfm :set fdm=manual<CR>
map <Leader>sfi :set fdm=indent<CR>
" set foldcolumn=1
" set fdm=syntax

" Fold shit above & below
:vnoremap <Leader>za <Esc>`<kzfgg`>jzfG`<

nmap <silent> <leader>fi :set foldmethod=indent<CR>
nmap <silent> <leader>fn :set foldmethod=manual<CR>zE


" === Diff mode ===

" === Mapping ===

" === Reading and writing files ===

" === The swap file ===

" === Command line editing ===

" === Executing external commands ===
  Plugin 'benmills/vimux'
  let g:VimuxSession = 'test'
  let g:VimuxRunnerPaneIndex = '0'

  Plugin 'ag.vim'

" === Running make and jumping to errors ===

" === Language specific ===

" === Multi-byte characters ===

" === Various ===

" Plugin 'gorkunov/smartgf.vim'
" let g:smartgf_enable_gems_search = 1

  ""http://stackoverflow.com/a/1889646/82062
  "let b:thisdir=expand("%:p:h")
  "let b:vim=b:thisdir."/.vim"
  "if (filereadable(b:vim))
  "    execute "source ".b:vim
  "endif

"Plugin 'vim-ruby/vim-ruby'
Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
"Plugin 'alpaca-tc/beautify.vim'
"kko gļučī npm
Plugin 'lukaszkorecki/CoffeeTags'

Plugin 'rails.vim'

"Plugin 'yonchu/accelerated-smooth-scroll'

Plugin 'hail2u/vim-css3-syntax'
Plugin 'matchit.zip'
Plugin 'tpope/vim-speeddating'
"Bundle 'tpope/vim-dispatch'

Plugin 'vim-multiedit'
"Bundle 'ervandew/screen'
Plugin 'tomtom/quickfixsigns_vim'
nnoremap <Leader>qf :QuickfixsignsToggle<CR>

Plugin 'kien/ctrlp.vim'
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
Plugin 'ctrlp-modified.vim'

Plugin 'Lokaltog/vim-easymotion'
Plugin 'LustyJuggler'
" Bundle 'Lokaltog/vim-powerline'
Plugin 'tpope/vim-repeat'

Plugin 'int3/vim-extradite'

" Plugin 'tpope/vim-surround'
Plugin 'Syntastic'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-endwise'
"gļuko šobrīd (!)
" Plugin 'gregsexton/gitv'
Plugin 'Tabular'
Plugin 'vimwiki'
Plugin 'mileszs/ack.vim'
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
" nnoremap <Leader>s viwy:Ack<Space><C-r>"<Cr>

" Bundle 'nviennot/vim-config'

" Bundle 'session.vim'
" Bundle 'xolox/vim-session'

" Conflicts with nerdtree. Not too useful anyway
" Bundle 'vim-signature'

Plugin 'sjl/gundo.vim'
nnoremap <F5> :GundoToggle<CR>

" tell it to use an undo file
set undofile
" set a directory to store the undo history
set undodir=~/.vimundo/

" Bundle 'mattn/pastebin-vim'
" source ~/.set_pastebin_key.vim

"===NEOCOMPLCACHE
Plugin 'Shougo/neocomplcache'
" Bundle 'Shougo/neocomplcache-snippets-complete'
Plugin 'ujihisa/neco-ruby'

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

" http://stackoverflow.com/questions/12975098/using-neocomplcache-and-clang-complete
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_overwrite_completefunc = 1
let g:neocomplcache_force_omni_patterns.c =
            \ '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objc =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:neocomplcache_force_omni_patterns.objcpp =
            \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
"===NEOCOMPLCACHE


Plugin 'groenewege/vim-less'


au BufNewFile,BufRead *.handlebars,*.hbs,*.html set ft=html syntax=handlebars
"au BufNewFile,BufRead *.coffee.md set ft=litcoffee syntax=litcoffee
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

inoremap j{ <Space>{<Space><Space>}<Left><Left>
inoremap jl =
inoremap jjl <Space>=<Space>
inoremap j. _
cnoremap j. _
inoremap kj <Esc>
inoremap j; :<Space>
inoremap j( ()<Left>
inoremap j[ []<Left>
inoremap j" ""<Left>
inoremap kj. k_

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
hi def link rubyRspec Function

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

" Toggle invisibles
" noremap <Leader>i :set list!<CR>
set listchars=eol:¬

" Drag Current Line/s Vertically
" noremap <A-j> :m+<CR>
" noremap <A-k> :m-2<CR>
" inoremap <A-j> <Esc>:m+<CR>
" inoremap <A-k> <Esc>:m-2<CR>
" vnoremap <A-j> :m'>+<CR>gv
" vnoremap <A-k> :m-2<CR>gv

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
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>g- :Git reset --hard<CR>

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
" hi Cursorline ctermbg=8 guifg=#808080

" Only have cursorline in current window
autocmd WinLeave * set nocursorline
autocmd WinEnter * set cursorline

nnoremap <Leader>rl :e log/development.log<CR>
nnoremap <Leader>cl :!/bin/echo "" > log/development.log<CR>

nnoremap <Leader>ot :tabe<CR>
nnoremap <Leader>ct :tabc<CR>
nnoremap <Leader>tw :tabe<CR>:VimwikiIndex<CR>

nnoremap <Leader>yp :let @+ = expand("%")<CR>

" >================vimux cmds
" Run the current file with rspec
map <silent> <Leader><CR> :w<CR>:call VimuxRunCommand("spec ".@% . ':' . line('.'))<CR>
map <silent> <Leader>a :w<CR>:call VimuxRunCommand("spec " . bufname("%"))<CR>

" Prompt for a command to run
map <Leader>i :VimuxPromptCommand<CR>

" Run last command executed by VimuxRunCommand
map <Leader>` :w<CR>:VimuxRunLastCommand<CR>

" Interrupt any command running in the runner pane
map <Leader>s :VimuxInterruptRunner<CR>
" <================vimux cmds

" ==>Breakpoints
" Delete all
nnoremap <Leader>`db :call ScreenShellSend("break --delete-all")<CR>
" List
nnoremap <Leader>`b :call ScreenShellSend("breakpoints")<CR>
map <Leader>`ab :w<CR> :call ScreenShellSend("break ".@% . ':' . line('.'))<CR>
"<============Screen commands

nnoremap <Leader>ssx :set syntax=xml<CR>
nnoremap <Leader>ssr :set syntax=ruby<CR>
nnoremap <Leader>ssn :set syntax=none<CR>

imap kjw <ESC>:w<CR>
imap jI <Space>\|\|<Left>

map <Leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

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
nmap zm zmzz
nmap zr zrzz
nmap zR zRzz

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

"a sleep function which allows vim to wait for the other processes to finish
com! -complete=command -nargs=+ Sleep call s:Sleep(<q-args>)
fun! s:Sleep(millisec)
  let ct = localtime()
  let dt = 0
  while dt < (a:millisec/1000)
    let dt = localtime() - ct
  endwhile
endfun

set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)

fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun

autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()





"if ! has('gui_running')
"    set ttimeoutlen=10
"    augroup FastEscape
"        autocmd!
"        au InsertEnter * set timeoutlen=0
"        au InsertLeave * set timeoutlen=1000
"    augroup END
"endif
set laststatus=2 " Always display the statusline in all windows





" test
"" Based on
"runtime colors/ir_black.vim
"
"let g:colors_name = "grb256"
"
"hi pythonSpaceError ctermbg=red guibg=red
"
"hi Comment ctermfg=darkgray
"
"hi StatusLine ctermbg=darkgrey ctermfg=white
"hi StatusLineNC ctermbg=black ctermfg=lightgrey
"hi VertSplit ctermbg=black ctermfg=lightgrey
"hi LineNr ctermfg=darkgray
"hi CursorLine     guifg=NONE        guibg=#121212     gui=NONE      ctermfg=NONE        ctermbg=234
"hi Function         guifg=#FFD2A7     guibg=NONE        gui=NONE      ctermfg=yellow       ctermbg=NONE        cterm=NONE
"hi Visual           guifg=NONE        guibg=#262D51     gui=NONE      ctermfg=NONE        ctermbg=236    cterm=NONE
"
"hi Error            guifg=NONE        guibg=NONE        gui=undercurl ctermfg=16       ctermbg=red         cterm=NONE     guisp=#FF6C60 " undercurl color
"hi ErrorMsg         guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16       ctermbg=red         cterm=NONE
"hi WarningMsg       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16       ctermbg=red         cterm=NONE
"hi SpellBad       guifg=white       guibg=#FF6C60     gui=BOLD      ctermfg=16       ctermbg=160         cterm=NONE
"
"" ir_black doesn't highlight operators for some reason
"hi Operator        guifg=#6699CC     guibg=NONE        gui=NONE      ctermfg=lightblue   ctermbg=NONE        cterm=NONE
"
"highlight DiffAdd term=reverse cterm=bold ctermbg=lightgreen ctermfg=16
"highlight DiffChange term=reverse cterm=bold ctermbg=lightblue ctermfg=16
"highlight DiffText term=reverse cterm=bold ctermbg=lightgray ctermfg=16
"highlight DiffDelete term=reverse cterm=bold ctermbg=lightred ctermfg=16
"
"highlight PmenuSel ctermfg=16 ctermbg=156
call vundle#end()
colorscheme wombat256mod
set guicolors
hi FoldColumn ctermbg=none ctermfg=darkgrey guibg=#000000 guifg=darkgrey
hi Folded ctermbg=none ctermfg=darkgrey guibg=#000000 guifg=darkgrey

hi Search cterm=none ctermfg=black ctermbg=yellow gui=none guifg=black guibg=yellow
hi String		ctermfg=118		cterm=none	guifg=#95e454	gui=italic
hi Directory ctermfg=118 guifg=#95e454 guifg=#95e454

hi VimwikiLink ctermfg=190 guifg=#dfff00
hi rubyTodo ctermfg=black ctermbg=190 guifg=black guibg=#dfff00
hi Search ctermfg=black ctermbg=190 guifg=black guibg=#dfff00
hi SignColumn ctermbg=none guibg=#000000

hi TabLine ctermfg=246 ctermbg=none cterm=none guifg=#949494 guibg=#000000 gui=none
hi TabLineSel ctermfg=118 ctermbg=none guifg=#87ff00 guibg=#000000
hi Title ctermfg=none ctermbg=none guifg=#000000 guibg=#000000
hi TabLineFill ctermfg=none ctermbg=none cterm=none guifg=#000000 guibg=#000000 gui=none
hi Search ctermfg=232 guifg=#080808
hi Normal ctermbg=none guibg=#000000
hi LineNr ctermbg=none guibg=#000000


hi DiffAdd ctermbg=118 ctermfg=232 cterm=bold guibg=#87ff00 guifg=#080808 gui=bold
hi DiffDelete ctermbg=Red ctermfg=232 cterm=bold guibg=Red guifg=#080808
hi DiffText ctermbg=190 ctermfg=232 guibg=#dfff00 guifg=#080808
" DiffChange DiffText
hi VertSplit ctermbg=none guibg=#000000
" hi CursorLine ctermbg=235 guibg=#262626
hi NERDTreeExecFile ctermfg=232
hi CursorLine ctermbg=none guibg=black

hi markdownH1  guifg=#ffffff
hi markdownH2  guifg=#ffffff
hi markdownH3  guifg=#ffffff

"olive green
"guibg=#4E9A06

set cc=80
highlight ColorColumn guibg=#393733
"highlight OverLength guibg=#040404
"match OverLength /\%81v.\+/
hi String     guifg=#b1d631
"hi Identifier guifg=#b1d631
"hi Boolean    guifg=#b1d631 
