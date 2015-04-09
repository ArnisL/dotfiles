" === Important ===
  " set guicolors
  " Necessary for true color support:
  " :h xterm-true-color
  "  execute "set t_8f=\e[38;2;%lu;%lu;%lum"
  "  execute "set t_8b=\e[48;2;%lu;%lu;%lum"
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  syntax on
  set linespace=0
  set autoread
  set nocompatible
  set nowrap
  set backspace=2 " make backspace work like most other apps
  set softtabstop=2
  set shiftwidth=2
  set tabstop=2
  set expandtab
  set nu " show line numbers
  set autoindent " turn on indentation, set smartindent

  " vundler config
  filetype off
  set rtp+=~/.vim/bundle/Vundle.vim
  call vundle#begin()
  Plugin 'gmarik/Vundle.vim'

" === Moving around, searching and patterns ===
  Plugin 'ag.vim'

  "Plugin 'easytree.vim'
  "nnoremap <Leader>n :EasyTree<CR>
  "let g:easytree_ignore_dirs = ['^bin', '^log', '^tmp', '^public', '^doc$', '^script']
  "nmap <A-L> :exe ':EasyTree '.expand('%:p:h')<CR>

  " NERD tree
  Plugin 'The-NERD-tree'
  Plugin 'jistr/vim-nerdtree-tabs'
  let g:NERDTreeWinSize=30
  let g:NERDTreeMinimalUI=1
  let g:NERDTreeDirArrows=1
  nmap <A-L> :NERDTreeFind<CR>
  nnoremap <Leader>n :NERDTreeTabsToggle<CR>
  let NERDTreeIgnore = ['^bin', '^log', '^tmp', '^doc$', '^script']

" === Syntax, highlighting and spelling ===
  nnoremap <Leader>ssx :set syntax=xml<CR>
  nnoremap <Leader>ssr :set syntax=ruby<CR>
  nnoremap <Leader>ssn :set syntax=none<CR>

  Plugin 'slim-template/vim-slim'
  au BufNewFile,BufRead *.slim setf slim

  "Plugin 'wombat256.vim'
  Plugin 'wombat'
  Plugin 'kchmck/vim-coffee-script'
  Plugin 'groenewege/vim-less'
  au BufNewFile,BufRead *.coffee setf coffee
  au BufNewFile,BufRead *.coffee set syntax=coffee
  au BufNewFile,BufRead *.less set syntax=less
  au BufNewFile,BufRead *.handlebars,*.hbs,*.html set ft=html syntax=handlebars
  " add syntax highlighting for RSpec
  autocmd BufRead *_spec.rb syn keyword rubyRspec describe context it specify it_should_behave_like before after setup subject its shared_examples_for shared_context let
  hi def link rubyRspec Function
  Plugin 'tpope/vim-markdown'
  Plugin 'nono/vim-handlebars'

  " Lightline <<
    Plugin 'itchyny/lightline.vim'
    let g:lightline = {
          \ 'colorscheme': 'wombat',
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
  set laststatus=2 " Always display the statusline in all windows

" === Folding ===
  map <Leader>sfs :set fdm=syntax<CR>
  map <Leader>sfm :set fdm=manual<CR>
  map <Leader>sfi :set fdm=indent<CR>

  " Fold shit above & below
  :vnoremap <Leader>za <Esc>`<kzfgg`>jzfG`<

  nmap <silent> <leader>fi :set foldmethod=indent<CR>
  nmap <silent> <leader>fn :set foldmethod=manual<CR>zE

" === Executing external commands ===
  Plugin 'benmills/vimux'
  let g:VimuxSession = '1'
  let g:VimuxRunnerPaneIndex = '3'
  map <silent> <Leader><CR> :w<CR>:call VimuxRunCommand("rspec ".@% . ':' . line('.'))<CR>
  map <silent> <Leader>a :w<CR>:call VimuxRunCommand("rspec " . bufname("%"))<CR>
  map <Leader>i :VimuxPromptCommand<CR>
  map <Leader>` :w<CR>:VimuxRunLastCommand<CR>
  map <Leader>s :VimuxInterruptRunner<CR>

" === Various ===
  Plugin 'majutsushi/tagbar'
  nmap <F8> :TagbarToggle<CR>
  "nvim has no ruby support :(
  "Plugin 'lukaszkorecki/CoffeeTags'
  Plugin 'rails.vim'
  "Plugin 'yonchu/accelerated-smooth-scroll'

  Plugin 'hail2u/vim-css3-syntax'
  Plugin 'matchit.zip'
  Plugin 'tpope/vim-speeddating'

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
  " nvim has no ruby support :(
  "Plugin 'LustyJuggler'
  Plugin 'tpope/vim-repeat'

  Plugin 'int3/vim-extradite'

  " Plugin 'tpope/vim-surround'
  Plugin 'Syntastic'
  Plugin 'tpope/vim-fugitive'
    nnoremap <Leader>gr :Gread<CR>
    nnoremap <Leader>gs :Gstatus<CR>
    nnoremap <Leader>gc :Gcommit<CR>
    nnoremap <Leader>gd :Gdiff<CR>
    nnoremap <Leader>gb :Gblame<CR>
    nnoremap <Leader>gw :Gwrite<CR>
    nnoremap <Leader>gl :Glog<CR>
    nnoremap <Leader>gp :Gpush<CR>
    nnoremap <Leader>g- :Git reset --hard<CR>
  Plugin 'airblade/vim-gitgutter'
    nmap ]h <Plug>GitGutterNextHunk
    nmap [h <Plug>GitGutterPrevHunk

  Plugin 'tpope/vim-unimpaired'
  Plugin 'tpope/vim-endwise'
  Plugin 'Tabular'
  Plugin 'vimwiki'
    let g:vimwiki_list = [{'path': '~/.vimwiki/'}]
    nnoremap <Leader>tw :tabe<CR>:VimwikiIndex<CR>

  Plugin 'mileszs/ack.vim'
    let g:ackprg="ack-grep -H --nocolor --nogroup --column"

  Plugin 'sjl/gundo.vim'
  nnoremap <F5> :GundoToggle<CR>
  set undofile
  set undodir=~/.vimundo/

  "Plugin 'Shougo/neocomplcache'
  "  " Bundle 'Shougo/neocomplcache-snippets-complete'
  "  Plugin 'ujihisa/neco-ruby'
  "  let g:neocomplcache_enable_at_startup = 1
  "  let g:neocomplcache_enable_smart_case = 1
  "  let g:neocomplcache_enable_auto_select = 1
  "  let g:neocomplcache_enable_fuzzy_completion = 1
  "  let g:neocomplcache_fuzzy_completion_start_length = 1

  "  " Recommended key-mappings.
  "  " <C-h>, <BS>: close popup and delete backword char.
  "  inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
  "  inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
  "  inoremap <expr><C-y>  neocomplcache#close_popup()
  "  inoremap <expr><C-f>  neocomplcache#close_popup()
  "  inoremap <expr><C-e>  neocomplcache#cancel_popup()

  "  " http://stackoverflow.com/questions/12975098/using-neocomplcache-and-clang-complete
  "  if !exists('g:neocomplcache_force_omni_patterns')
  "      let g:neocomplcache_force_omni_patterns = {}
  "  endif
  "  let g:neocomplcache_force_overwrite_completefunc = 1
  "  let g:neocomplcache_force_omni_patterns.c =
  "              \ '[^.[:digit:] *\t]\%(\.\|->\)'
  "  let g:neocomplcache_force_omni_patterns.cpp =
  "              \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  "  let g:neocomplcache_force_omni_patterns.objc =
  "              \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  "  let g:neocomplcache_force_omni_patterns.objcpp =
  "              \ '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
  "  let g:clang_complete_auto = 0
  "  let g:clang_auto_select = 0
  "  let g:clang_use_library = 1

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

  nmap <A-l> gt
  nmap <A-h> gT
  " map escape sequences to their alt combos
  " http://stackoverflow.com/a/10216459/82062
  let c='A'
  while c <= 'Z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
  endw
  set timeout ttimeoutlen=10

  let c='a'
  while c <= 'z'
    exec "set <a-".c.">=\e".c
    exec "imap \e".c." <z-".c.">"
    let c = nr2char(1+char2nr(c))
  endw
  set timeout ttimeoutlen=10

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

  " Resize splits when the window is resized
  au VimResized * exe "normal! \<c-w>="

  " Quickly open .vimrc file
  nnoremap <Leader>vv :e $MYVIMRC<CR>

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
  noremap <Leader>::: :s/:\(\S*\) =>/\1:/g<CR>

  " fix damn search
  set ignorecase
  set smartcase
  set incsearch

  " color current line background dark green
  " hi Cursorline ctermbg=8 guifg=#808080

  nnoremap <Leader>ot :tabe<CR>
  nnoremap <Leader>ct :tabc<CR>

  nnoremap <Leader>yp :let @+ = expand("%")<CR>

  imap kjw <ESC>:w<CR>
  imap kjwq <ESC>:wq<CR>
  imap jI <Space>\|\|<Left>

  map <Leader>c :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
  \ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
  \ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

  nmap > ]qzz
  nmap < [qzz
  nmap n nzz
  nmap N Nzz

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

  call vundle#end()
  filetype plugin indent on
  colorscheme wombat

  hi FoldColumn ctermbg=none ctermfg=darkgrey guibg=#002B36 guifg=darkgrey
  hi Folded ctermbg=none ctermfg=darkgrey guibg=#002B36 guifg=darkgrey

  hi Search cterm=none ctermfg=black ctermbg=yellow gui=none guifg=black guibg=yellow
  hi Directory ctermfg=118 guifg=#95e454 guifg=#9BD65C

  hi VimwikiLink ctermfg=190 guifg=#dfff00
  hi rubyTodo ctermfg=black ctermbg=190 guifg=black guibg=#dfff00
  hi Search ctermfg=black ctermbg=190 guifg=black guibg=#dfff00
  hi SignColumn ctermbg=none guibg=#002B36

  hi TabLine ctermfg=246 ctermbg=none cterm=none guifg=#949494 guibg=#002B36 gui=none
  hi TabLineSel ctermfg=118 ctermbg=none guifg=#87ff00 guibg=#002B36
  hi Title ctermfg=none ctermbg=none guifg=#000000 guibg=#002B36
  hi TabLineFill ctermfg=none ctermbg=none cterm=none guifg=#000000 guibg=#002B36 gui=none
  hi Search ctermfg=232 guifg=#080808
  hi Normal ctermbg=none guibg=#002B36
  hi LineNr ctermbg=none guibg=#002B36
  hi NonText guibg=#002B36

  hi DiffAdd ctermbg=118 ctermfg=232 cterm=bold guibg=#87ff00 guifg=#080808 gui=bold
  hi DiffDelete ctermbg=Red ctermfg=232 cterm=bold guibg=Red guifg=#080808
  hi DiffText ctermbg=190 ctermfg=232 guibg=#dfff00 guifg=#080808
  hi VertSplit ctermbg=none guibg=#002B36
  hi CursorLine ctermbg=none guibg=#003340
  hi CursorLine ctermbg=none guibg=#002B36

  hi markdownH1  guifg=#ffffff
  hi markdownH2  guifg=#ffffff
  hi markdownH3  guifg=#ffffff

  hi ColorColumn guibg=#002B36

  hi String guifg=#9BD65C

  hi GitGutterAdd guifg=#87ff00
  hi GitGutterDelete guifg=#FF3333

  hi SyntasticWarningSign guifg=#ffd700
  hi SyntasticErrorSign guifg=#FF3333
  "olive green #4E9A06
  hi NERDTreeExecFile ctermfg=232
