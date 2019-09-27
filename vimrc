" vim-plugin -----------------{{{
set rtp +=~/.vim/bundle/plug
call plug#begin('~/.vim/cdir_plugins')


Plug 'itchyny/lightline.vim'


Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'

Plug 'mileszs/ack.vim'

"Plug 'scrooloose/nerdtree'

Plug 'mbbill/undotree'

Plug 'majutsushi/tagbar'

Plug 'ludovicchabant/vim-gutentags'

Plug 'inside/vim-search-pulse'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

"Plug 'skammer/vim-css-color' , { 'for' : ['css' , 'html'] }
" C

Plug 'walm/jshint.vim' , { 'for' : [ 'javascript' ] }

" LaTeX
Plug 'vim-latex/vim-latex' , { 'for' : [ 'tex' , 'plaintex' ] }

"Plug 'drmingdrmer/xptemplate'

Plug 'sirver/ultisnips'

Plug 'honza/vim-snippets'

call plug#end()
"}}}



" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <silent><expr> <c-space> coc#refresh()


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

"tab config------------{{{

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

"}}}

set scrolloff=5  " a margem do fim da tela
set mouse=""
set lazyredraw "melhoria de desempenho
set hidden "melhor uso de buffers na mesma janela
set ttyfast "melhoria de desempenho, ver :h ttyfast
"set list "Mostrar tabs e trails(como o caracter •)
set listchars=tab:>-,space:•,extends:»,precedes:« "Extends aparecem com a funcao nowrap ativada
set noshowmode
set breakindent
let g:tex_flavor='latex'



"lightline----------------{{{
let g:lightline = {
    \ 'colorscheme':'one',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'filename',  'gitbranch'  ] , ['lineinfo','percent' ] ],
    \   'right': [ ['function' ] ,[],[] , ['fileencoding', 'filetype','fileformat'] ],
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'filename':  'Algo',
    \   'function': 'CurrentTag'
    \ },
    \ }

function! Algo()
    let s:texto = expand('%:t') !=# '' ? expand('%:t') : ''
    return s:texto . (&readonly ? ' RO' : '') . (&modified ? ' +' : '')
endfunction

function! CurrentTag()
    let l:texto = tagbar#currenttag("%s" , "")
    let l:texto = strpart(l:texto , 0 , 30)
    return l:texto
endfunction

"}}}

"UltiSnips---------------------{{{


    let g:UltiSnipsExpandTrigger="<c-z>"
    let g:UltiSnipsJumpForwardTrigger="<c-z>"
    let g:UltiSnipsJumpBackwardTrigger="<c-\>"

"}}}

"hi Visual term=reverse cterm=reverse guibg=black
"hi SpecialKey term=reverse cterm=reverse guibg=black
"alterar a cor acima


"gutentags----------{{{
   let g:gutentags_project_root  = [ 'tags' ]
"}}}

"alguns autocmd------------------{{{
    " retornar o cursor a posição em que estava quando fecho o arquivo
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
    " para criar e salvar os folds feitos no arquivo, deve salvar outras
    " coisas mas não sei qual
"}}}

" alguns maps -----------------{{{
:nnoremap <space> viw

:nnoremap <enter> o<Esc>

" coloca texto selecionado entre aspas
:vnoremap <leader>" vi"

" palavra atual entre aspas
:nnoremap <leader>" vi"

:inoremap <leader>j <Esc>:call Olamundo()<cr>

"map para pegar trailingspace

"troca o modo dos numeros
map <leader>l :set relativenumber!<CR>


"map para auto ident
nnoremap <leader><TAB> mmgg=G'm

"map para colar e identar , teste.
"nnoremap p mmp'[V']'m=



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

:noremap <silent> <F8> :TagbarToggle<CR>


"tab
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" }}}

"Abreviations--------------------------{{{
    abbreviate lorem Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
"}}}

"Vim-LaTeX --------------------------{{{
    let g:Tex_CustomTemplateDirectory = '$HOME/.vim/templates/latex/'
    augroup vimLatex
        autocmd!
        autocmd FileType tex :set tw=120
    augroup END
"}}}

"gvim-----------------{{{
    set guifont=Monospace\ 12
"}}}

"conf de temas ------------------ {{{
"let g:gruvbox_italic=1
set background=dark
":colorscheme gruvbox
if &term =~ "linux"
    colorscheme crayon
    hi ExtraWhitespace ctermbg=blue
else
    colorscheme meu
end

match ExtraWhitespace /\s\+$/
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
    autocmd BufRead,BufNewFile *.c set filetype=c.doxygen
    autocmd FileType c,c.doxygen,cuda :inoremap <buffer> <leader>i <Esc>I#include <<Esc>A.h>
    autocmd FileType c,c.doxygen,cuda :inoremap <buffer> <leader>I <Esc>I#include "<Esc>A.h"
    "autocmd FileType c,c.doxygen :let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
augroup END

augroup grupoCPP
    autocmd!
    autocmd FileType cpp :nnoremap <buffer> <leader>p ma$"nyb$F "yy^/getters<CR>o<esc>xxa<c-r>y <c-r>n<esc>F l~F aget<esc>A() const;<esc>/setters<CR>o<esc>xxavoid <c-r>n<esc>F l~F aset<esc>A(<c-r>y <c-r>n);<esc>'aj:noh<CR>
    autocmd FileType cpp :nnoremap <buffer> <leader>P ma$"nyb$F "yy^?class <CR>w"cyeGo<c-r>y <c-r>n<esc>F l~F a<c-r>c::get<esc>A() const{<CR>return this-><c-r>n;<CR>}<CR><esc>3k"fd4d:let @G=@f<CR>ovoid <c-r>n<esc>F l~F a<c-r>c::set<esc>A(<c-r>y <c-r>n){<CR>this-><c-r>n = <c-r>n;<CR>}<CR><esc>3k"fd4d:let @S=@f<CR>'aj:noh<CR>:w<CR>
    autocmd FileType cpp :inoremap <buffer> <leader>i <Esc>I#include <<Esc>A>
    autocmd FileType cpp :inoremap <buffer> <leader>I <Esc>I#include "<Esc>A.hpp"
augroup END

augroup grupoCPPeC
    autocmd!
    autocmd FileType c,c.doxygen,cpp,cuda :iabbrev <buffer> imain int main (int argc , char* argv[]){<Enter>return 0;<Enter>}<up><up><end><Enter>
    autocmd FileType c,c.doxygen,cpp,cuda :let @s=''
    autocmd FileType c,c.doxygen,cpp,cuda :let @g=''
    autocmd FileType c,c.doxygen,cpp,cuda :nnoremap <buffer> <leader>g I//<Esc>
    autocmd FileType c,c.doxygen,cpp,cuda :inoremap <buffer> <leader>g <Esc>mnI//'ci
    autocmd FileType c,c.doxygen,cpp,cuda :vnoremap <buffer> <leader>g <Esc>`<i/*<Esc>`>a*/<Esc>
    autocmd FileType c,c.doxygen,cpp,cuda :let &path="lib,"
    autocmd FileType c,c.doxygen,cpp,cuda :inoremap <buffer> çu <Esc>Iusing std::<Esc>A;
    autocmd FileType c,c.doxygen,cpp,cuda :nnoremap <buffer> çf Va{zf
"}
augroup END
"}}}

"autocmd xml e html ------------{{{
    autocmd FileType html,xml :inoremap <buffer> </ </<C-X><C-O><Esc>mb==`ba
    autocmd FileType html,xml :iabbrev <buffer> <html> <html><CR><head><CR><title></<CR></<CR><body><CR></<CR></
"}}}

"txt --------------- {{{
    autocmd FileType txt,text :set tw=100
"}}}

" autocmd - vimscript	----------------------{{{
augroup arquivosVim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
"}}}

"source das conf local
source $HOME/.vim/source_vimrc


:function Olamundo()
:   execute "normal! /<+.*+>\<CR>va<"
:   let carac = getchar()
    let linha = call getLine(".")
    echom linha
    echom "mensagem minha" . carac
:endfunction

