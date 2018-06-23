" vim-plugin -----------------{{{
set rtp +=~/.vim/bundle/plug
call plug#begin('~/.vim/cdir_plugins')


Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'


Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'mileszs/ack.vim'

Plug 'scrooloose/nerdtree'

Plug 'sjl/gundo.vim'

Plug 'Shougo/neocomplete' , { 'on' : 'NeoCompleteEnable' }

" C
Plug 'Valloric/YouCompleteMe' , { 'for' : ['c' , 'cpp' , 'c.doxygen' , 'python' , 'py' ]}

Plug 'xolox/vim-easytags' , { 'for' : ['c' , 'cpp' , 'c.doxygen' ]}

Plug 'xolox/vim-misc' , { 'for' : ['c' , 'cpp' , 'c.doxygen' ]}

Plug 'majutsushi/tagbar' , { 'for' : ['c' , 'cpp' , 'c.doxygen' ]}

" LaTeX
Plug 'vim-latex/vim-latex' , { 'for' : [ 'tex' , 'plaintex' ] }

call plug#end()
"}}}

let g:solarized_termcolors=256

let mapleader = "ç"
let &path.="lib,"

syntax on

set exrc
set secure
" Numeros
set number
" Sublinhação
set hls is
set showcmd
set laststatus=2

"tab config
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

set scrolloff=5
set mouse=""
set lazyredraw "melhoria de desempenho
set hidden "melhor uso de buffers na mesma janela
set ttyfast "melhoria de desempenho, ver :h ttyfast
"set list "Mostrar tabs e trails(como o caracter •)
set listchars=tab:>-,space:•,extends:»,precedes:« "Extends aparecem com a funcao nowrap ativada
let g:tex_flavor='latex'


"hi Visual term=reverse cterm=reverse guibg=black
"hi SpecialKey term=reverse cterm=reverse guibg=black
"alterar a cor acima

"Vim-LaTeX --------------------------{{{
    let g:Tex_CustomTemplateDirectory = '$HOME/.vim/templates/latex/'
"}}}

"gvim-----------------{{{
    set guifont=Monospace\ 12
"}}}

"Vim-Airline --------------- {{{
    let g:airline_symbols_ascii = 1
  let g:airline#extensions#tagbar#enabled = 0
"}}}

"conf de temas ------------------ {{{
"let g:gruvbox_italic=1
let g:airline_theme='dark'
set background=dark
":colorscheme gruvbox
colorscheme solarized
highlight ExtraWhitespace ctermbg=darkgreen guibg=lightgreen
"if &term =~ "xterm\\|rxvt"
"	" use an orange cursor in insert mode
"	let &t_SI = "\<Esc>]12;orange\x7"
"	" use a red cursor otherwise
"	let &t_EI = "\<Esc>]12;red\x7"
"	silent !echo -ne "\033]12;red\007"
"	" reset cursor when vim exits
"	autocmd VimLeave * silent !echo -ne "\033]12;black\007"
"	" use \003]12;gray\007 for gnome-terminal and rxvt up to version 9.21
"endif
"}}}

"undo confgs ----------------- {{{
if !isdirectory($HOME."/.vim")
    call mkdir($HOME."/.vim", "", 0770)
endif
if !isdirectory($HOME."/.vim/undo-dir")
    call mkdir($HOME."/.vim/undo-dir", "", 0700)
endif
set undodir=~/.vim/undo-dir "pasta que armazena undos
set undofile "permite que o historico de undos seja salvo em um arquivo
set undolevels=1000 "tamanho do historico de undos
"}}}

" alguns maps -----------------{{{
:nnoremap <space> viw

:nnoremap <enter> o<Esc>

" coloca texto selecionado entre aspas
:vnoremap <leader>" <Esc>`<i"<Esc>`>la"<Esc>

" palavra atual entre aspas
:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel

"map para pegar trailingspace

"troca o modo dos numeros
map <leader>l :set relativenumber!<CR>


"map para auto ident
nnoremap <leader><TAB> mmgg=G'm

"map para colar e identar , teste.
"nnoremap p mmp'[V']'m=


"map para trocar de buffer e aumentar ele

:nnoremap <S-Tab>  <C-w><C-w><C-w>_<C-w><bar>

:inoremap <S-Tab>  <C-d>

"" desativa a roda ¬¬

:nmap <ScrollWheelUp> <nop>
:nmap <S-ScrollWheelUp> <nop>
:nmap <C-ScrollWheelUp> <nop>
:nmap <ScrollWheelDown> <nop>
:nmap <S-ScrollWheelDown> <nop>
:nmap <C-ScrollWheelDown> <nop>
:nmap <ScrollWheelLeft> <nop>
:nmap <S-ScrollWheelLeft> <nop>
:nmap <C-ScrollWheelLeft> <nop>
:nmap <ScrollWheelRight> <nop>
:nmap <S-ScrollWheelRight> <nop>
:nmap <C-ScrollWheelRight> <nop>


"tab
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}

" ASSEMBLY ---------------------- {{{
augroup ASSEMBLY
    autocmd!
    autocmd FileType asm :set ft=mips
augroup END
"}}}

"*autocmd-events*
" autocmd -C e C++ ----------------------{{{
augroup grupoC
    autocmd!
    autocmd BufRead,BufNewFile *.h,*.c set filetype=c.doxygen
    autocmd FileType c,c.doxygen :let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
augroup END

augroup grupoCPP
    autocmd!
    autocmd FileType cpp :let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_confcpp.py'
    autocmd FileType cpp :nnoremap <buffer> <leader>p ma$"nyb$F "yy^/getters<CR>o<esc>xxa<c-r>y <c-r>n<esc>F l~F aget<esc>A() const;<esc>/setters<CR>o<esc>xxavoid <c-r>n<esc>F l~F aset<esc>A(<c-r>y <c-r>n);<esc>'aj:noh<CR>
    autocmd FileType cpp :nnoremap <buffer> <leader>P ma$"nyb$F "yy^?class <CR>w"cyeGo<c-r>y <c-r>n<esc>F l~F a<c-r>c::get<esc>A() const{<CR>return this-><c-r>n;<CR>}<CR><esc>3k"fd4d:let @G=@f<CR>ovoid <c-r>n<esc>F l~F a<c-r>c::set<esc>A(<c-r>y <c-r>n){<CR>this-><c-r>n = <c-r>n;<CR>}<CR><esc>3k"fd4d:let @S=@f<CR>'aj:noh<CR>:w<CR>
augroup END

augroup grupoCPPeC
    autocmd!
    autocmd FileType c,c.doxygen,cpp :iabbrev <buffer> imain int main (int argc , char* argv[]){<Enter>return 0;<Enter>}<up><up><end><Enter>
    autocmd FileType c,c.doxygen,cpp :let @s=''
    autocmd FileType c,c.doxygen,cpp :let @g=''
    autocmd FileType c,c.doxygen,cpp :nnoremap <buffer> <leader>g I//<Esc>
    autocmd FileType c,c.doxygen,cpp :inoremap <buffer> <leader>g <Esc>mnI//'ci
    autocmd FileType c,c.doxygen,cpp :vnoremap <buffer> <leader>g <Esc>`<i/*<Esc>`>a*/<Esc>
    autocmd FileType c,c.doxygen,cpp :inoremap <buffer> <leader>in <Esc>I#include <<Esc>A.h>
    autocmd FileType c,c.doxygen,cpp :let &path="lib,"
    autocmd FileType c,c.doxygen,cpp :inoremap <buffer> çu <Esc>Iusing std::<Esc>A;
    autocmd FileType c,c.doxygen,cpp :nnoremap <buffer> çf Va{zf
"}
    autocmd FileType c,c.doxygen,cpp :noremap <silent> <F8> :TagbarToggle<CR>
augroup END
"}}}

inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" autocmd - vimscript	----------------------{{{
augroup arquivosVim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

"source das conf local
source $HOME/.vim/source_vimrc

