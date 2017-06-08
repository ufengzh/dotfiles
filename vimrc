" basic settings
set nu         " set number
set rnu        " set relativenumber
set ts=4       " set tabstop=4
set sw=4       " set shiftwidth=4
set et         " set expandtab
set sta        " set smarttab
set hi=1000    " set history=1000
set ic         " set ignorecase
set scs        " set smartcase
set bs=2       " set backspace=indent,eol,start

" c/c++ options
set ai         " set autoindent
set si         " set smartindent
set sm         " set showmatch
set cino=:0g0t0(sus
" for ctags
set tags=tags

syntax on

set wildmenu
set wildmode=longest,list,full

" status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2

" file encoding
set fileencoding=utf-8
set fileencodings=utf-8,gb18030,gbk

" mapping key
let mapleader = "."
nnoremap <space> viw
inoremap <c-d> <esc>ddi
inoremap jk <esc>
" inoremap <esc> <nop>
nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

" filetype settings
if has("autocmd")
    " same to `filetype plugin indent on`
    filetype on
    filetype plugin on
    filetype indent on
    
    " For all text files set `textwidth` to 78 characters.
    autocmd FileType text setlocal textwidth=78

    " Opening Vim help in a vertical split window.
    autocmd FileType help wincmd L
    
    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \ exe "normal g'\"" |
                \ endif
endif " has("autocmd")

" personal function
function! MyTitle()
call setline(1, "/*****************************************************")
call append(line("."), " * Author: zhuxianfeng")
call append(line(".")+1, " * Time: ".strftime("%c"))
call append(line(".")+2, " * Filename: ".expand("%"))
call append(line(".")+3, " * Description: ")
call append(line(".")+4, " *****************************************************/")
endf
nnoremap <F8> <Esc>:call MyTitle()<CR><Esc>:$<Esc>o

" Vundle setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'majutsushi/tagbar'
Plugin 'scrooloose/nerdtree'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'easymotion/vim-easymotion'
" Plugin 'OmniCppComplete'
" Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" AutoComplPop settings
let g:AutoComplPop_Behavior = {
			\ 'c': [ {'command' : "\<C-x>\<C-o>",
			\ 'pattern' : ".",
			\ 'repeat' : 0}
			\ ]
			\}

" tagbar settings
let g:tagbar_left = 1
let g:tagbar_width = 32
let g:tagbar_sort = 0
nnoremap <silent> <F2> :TagbarToggle<CR>
autocmd VimEnter * nested :TagbarOpen

" nerdtree settings
let NERDTreeWinPos = "right"
let NERDTreeWinSize = 32
let NERDTreeShowLineNumbers=1
nnoremap <F3> :NERDTreeToggle<CR>
" autocmd VimEnter * nested :NERDTree
" autocmd VimEnter * :wincmd p
nnoremap <silent> <leader>r :NERDTreeFind<CR>
nnoremap <silent> <C-i> :call NERDTreeToggleInCurDir()<CR>
function! NERDTreeToggleInCurDir()
    " If NERDTree is open in the current buffer
    if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        execute ":NERDTreeClose"
    else
        execute ":NERDTreeFind"
    endif
endfunction

" BufExplorer settings
nnoremap <F4> :BufExplorer<CR>

" for ConqueTerm. zsh is too slow in vim.
" map <F5> :ConqueTerm zsh<CR>
nnoremap <F5> :ConqueTerm bash<CR>

" ctrlp settings
" let g:ctrlp_map = '<leader>p'
" let g:ctrlp_cmd = 'CtrlP'
" map <leader>f :CtrlPMRU<CR>
nnoremap <C-r> :CtrlPBufTagAll<CR>
nnoremap <C-e> :CtrlPTag<CR>
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
            \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
            \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=16
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

" vim-go settings
let g:go_bin_path = expand("~/.vim/bundle/gotools")

" easymotion settings
let g:EasyMotion_leader_key = ','
" map <Leader> <Plug>(easymotion-prefix)
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1
" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)
" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)