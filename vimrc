"vimrc by Omar Sosa <omarfsosa@gmail.com>
" Inspired by --A Good Vimrc-- by Douglas Black
" Last update: <13-09-2018 16:52:22 omarsosa>


" Colors, theme and font {{{
syntax enable           " enable syntax processing
set background=dark
colorscheme badwolf
"colorscheme base16-default-dark      " needs to be installed
"highlight Comment cterm=italic      
"set termguicolors
"set guifont=Meslo\ LG\ S\ for\ Powerline:h14
"set guifont=Roboto\ Mono\ Thin\ for\ Powerline:h15
" }}}
" Misc {{{
"make backspace behave normaly
set backspace=indent,eol,start
"to copy paste like normal people do:
set clipboard=unnamed   
" enable the mouse, copy/paste doesn't work nice if mouse is enabled.
"set mouse=a 
set spelllang=en
set spellfile=$HOME/.vim/spell/en.utf-8.add
" set spliting windows to the right / bottom by default
set splitbelow
set splitright
filetype indent on
filetype plugin on
" }}}
" Spaces & Tabs {{{
set tabstop=4           " 4 space tab
set expandtab           " use spaces for tabs
set softtabstop=4       " 4 space tab
set shiftwidth=4
"set modelines=1         " read the bottom line of file, commented
set autoindent
" }}}
" UI Layout {{{
set number              " show current line number
set relativenumber      " show line number relative to current line
set showcmd             " show command in bottom bar
set cursorline          " highlight current line
set wildmenu            " show available commands on pressing <TAB>
set lazyredraw          " don't redraw the screen when not needed
set showmatch           " higlight matching parenthesis
set fillchars=vert:\|
" }}}
" Searching {{{
set ignorecase          " ignore case when searching
set incsearch           " search as characters are entered
set hlsearch            " highlight all matches
" }}}
" Folding {{{
"set foldmethod=marker

set foldenable
set foldmethod=syntax
set foldlevelstart=10
nnoremap <Space> za
vnoremap <Space> za

" }}}
" Cursor navigation {{{
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap j gj
nnoremap k gk
" }}}
" Leader Shortcuts & remaps{{{
let mapleader=";"
nnoremap <leader>ev :vsp $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
"turn off search highlight
nnoremap <leader><space> :nohlsearch<CR>
" writing file automatically jumps to timestamp. Use F11 for saving, and
" return back to previous position, and center cursor on screen. How this
" happens is defined in Autogroups section below
nnoremap <F11> :w<CR><bar>:echo "Written and updated time-stamp"<CR><C-O>zz

"function to comment/uncomment
function! Comment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^/\#/
  elseif ext == 'js'
    silent s:^:\/\/:g
  elseif ext == 'vim'
    silent s:^:\":g
  endif
endfunction

function! Uncomment()
  let ext = tolower(expand('%:e'))
  if ext == 'php' || ext == 'rb' || ext == 'sh' || ext == 'py'
    silent s/^\#//
  elseif ext == 'js'
    silent s:^\/\/::g
  elseif ext == 'vim'
    silent s:^\"::g
  endif
endfunction

map <leader>c :call Comment()<CR>
map <leader>u :call Uncomment()<CR>

" }}}
" Vim Plug {{{
"To install vim Plug run the following line one the terminal, then resource
"the vimrc and then do :PlugInstall to install the plugins
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
call plug#begin('~/.vim/plugged')
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'enricobacis/vim-airline-clock'
Plug 'lervag/vimtex'
Plug 'tpope/vim-surround'
"Plug 'jewes/Conque-Shell'
Plug 'nvie/vim-flake8'
Plug 'SirVer/ultisnips'
"Plug 'rafi/awesome-vim-colorschemes'
"Plug 'Konfekt/fastfold'
call plug#end()
" }}}
" Airline {{{
set laststatus=2

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

"short name for modes
let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }

let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = '' "from space mono for powerline font
let g:airline_symbols.readonly = ''
let g:airline_section_b = '%-0.10{getcwd()}' "section b is path
let g:airline_section_c = '%t'              "section c is filename

let g:airline#extensions#whitespace#enabled = 0 "do not trail whitespaces
let g:airline#parts#ffenc#skip_expected_string='utf-8[unix]' "when editin a utf-8 encoding file, don't show this in the powerline. 
" }}}
" vimtex {{{
"let g:vimtex_enabled = 0   
let g:tex_flavor = 'latex'
let g:vimtex_fold_enabled=1

let g:vimtex_view_general_viewer = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'
"}}}
" Ultisnips {{{
let g:UltiSnipsExpandTrigger ="<tab>"
let g:UltiSnipsJumpForwardTrigger="<leader><leader>"
let g:UltiSnipsJumpBackwardTrigger="<leader>b"
let g:UltiSnipsEditSplit ="vertical"
let g:UltiSnipsSnippetsDir ="~/.vim/ultisnips"
let g:UltiSnipsSnippetsDirectories =["ultisnips"]
"}}}
" Autogroups {{{
augroup vimtex
    autocmd!
    autocmd BufWritePre *.* :%s/^\s*\(\/\/\|#\|%\|"\)\s\+Last\s\+update:\s\+<\zs.*/\=strftime('%d-%m-%Y') . ' ' . strftime('%H:%M:%S') . ' ' . $USER . '>'/e 
    autocmd FileType tex noremap <F10> :setlocal spell!<CR>
    autocmd FileType tex map <F12> \lv
    autocmd FileType tex map <F5> \ll
    autocmd FileType tex noremap <leader>f0 :set foldlevel=0<CR>
    "autocmd Filetype tex setlocal foldmarker=<<<,>>>
    autocmd FileType tex setlocal foldlevel=0
    
    autocmd FileType snippets setlocal foldmethod=marker
    autocmd FileType snippets setlocal foldlevel=0

    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python setlocal foldlevel=99
    autocmd FileType python setlocal smartindent cinwords=if,elif,else,for,while,try,except,finally
    autocmd FileType python map <F12> :!python % <CR>
    
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType vim setlocal foldlevel=0

   augroup END
"}}}
"
" vim:foldmethod=marker:foldlevel=0
