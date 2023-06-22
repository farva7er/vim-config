set nocompatible              " be iMproved, required
filetype off                  " required
set nowrap

set wildmenu
set wildmode=list:longest,full

set completeopt-=menu

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" PolyGlot
Plugin 'sheerun/vim-polyglot'

" FSwitch
Plugin 'derekwyatt/vim-fswitch'

" C# building support
Plugin 'datamadsen/vim-compiler-plugin-for-dotnet'

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
" filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Fswitch config
au! BufEnter *.cpp let b:fswitchdst = 'hpp,h' | let b:fswitchlocs = '.'

" ------------------------------------------------------------
" Vim configuration
" ------------------------------------------------------------

set relativenumber      " Enable line numbers
syntax on               " Enable synax highlighting
set incsearch           " Enable incremental search
set hlsearch            " Enable highlight search
set splitbelow          " Always split below"
set mouse=v             " Enable mouse drag on window splits
set tabstop=4           " How many columns of whitespace a \t is worth
set shiftwidth=4        " How many columns of whitespace a “level of "indentation” is worth
set noexpandtab         " Use spaces when tabbing

"set list
set listchars=trail:-   " Display trailing whitespaces

if !has('nvim')
    set termwinsize=12x0    " Set terminal size
 endif

"set background=dark      Set background 
colorscheme handmade-hero

hi CursorLine cterm=NONE ctermbg=17 ctermfg=none guibg=darkblue guifg=white
"set cursorline

" ------------------------------------------------------------
" Key mappings
" ------------------------------------------------------------

" General
nmap        <C-B>     :buffers<CR>
nmap        <C-J>     :term<CR>

nnoremap <C-l> :<C-u>call search('^.\+')<CR>

" Build mappings
nnoremap    <F5>   	:make<CR>
nnoremap	<F7>	:cp<CR>
nnoremap	<F8>	:cn<CR>

" Substitude mapping
nnoremap <F9> :,$s///gc

function! s:insert_gates()
   let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
   execute "normal! i#ifndef " . gatename
   execute "normal! o#define " . gatename . " "
   execute "normal! Go#endif /* " . gatename . " */"
   normal! kk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost [^l]* cwindow
	autocmd QuickFixCmdPost [^l]* call OpenQuickFixList()
augroup END

function OpenQuickFixList()
	cclose
	cwindow
	wincmd o
	vsplit
	wincmd p
	wincmd =
endfunction

nnoremap  <C-s>h :FSLeft<CR>
nnoremap  <C-s>l :FSRight<CR>

set tags=tags;~
