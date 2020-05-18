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

Plug 'inside/vim-search-pulse'

Plug 'JuliaEditorSupport/julia-vim' , { 'for' : [ 'julia' ] }

Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete.vim'

Plug 'NLKNguyen/papercolor-theme'


Plug 'vim/killersheep'

"Plug 'skammer/vim-css-color' , { 'for' : ['css' , 'html'] }
" C

" LaTeX
Plug 'vim-latex/vim-latex' , { 'for' : [ 'tex' , 'plaintex' ] }

"snipts
Plug 'SirVer/ultisnips'

call plug#end()
"}}}


" if para mudar alguns comandos quando o teclado for dvorak

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
"set expandtab

"}}}

"fold config {{{
	set foldcolumn=1
	set nofoldenable
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

"folding

"vim-lsp -------------------- {{{
	if(executable('clangd'))
 		au User lsp_setup call lsp#register_server({
 					\ 'name': 'clangd',
 					\ 'cmd': {server_info->['clangd', '-background-index']},
 					\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
 					\ 'initialization_options': {},
 					\ 'whitelist': ['c.doxygen', 'c', 'cpp', 'objc', 'objcpp', 'cc'],
 					\})
	endif

	if executable('typescript-language-server')
		au User lsp_setup call lsp#register_server({
		  \ 'name': 'javascript support using typescript-language-server',
		  \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
		  \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
		  \ 'whitelist': ['javascript', 'javascript.jsx', 'javascriptreact']
		  \ })
	endif

	if executable('pyls')
		au User lsp_setup call lsp#register_server({
					\ 'name': 'pyls',
					\ 'cmd': {server_info->['pyls']},
					\ 'whitelist': ['python'],
					\})
	endif


	let g:lsp_diagnostics_enabled = 1
	let g:lsp_signs_enabled = 1
	let g:lsp_diagnostics_float_cursor = 1
	let g:lsp_diagnostics_echo_delay = 1000
	let g:lsp_hover_conceal = 0
	set completeopt-=preview
	function! s:on_lsp_buffer_enabled() abort
		setlocal omnifunc=lsp#complete
		setlocal signcolumn=yes
		nmap <buffer> <leader>d <plug>(lsp-definition)
		nmap <buffer> <leader>n <plug>(lsp-next-diagnostic)
		nmap <buffer> <leader>N <plug>(lsp-previous-diagnostic)
		nmap <buffer> <leader>r <plug>(lsp-rename)
		nmap <buffeR> <leader>* <plug>(lsp-next-reference)
		nmap <buffeR> <leader># <plug>(lsp-previous-reference)
	endfunction
	augroup lsp_install
		au!
		" call s:on_lsp_buffer_enabled only for languages that has the server registered.
		autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
	augroup END

	inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
	inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"


"}}}

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

"ultisnippets-------------{{{
	let g:UltiSnipsExpandTrigger="<c-k>"
	let g:UltiSnipsJumpForwardTrigger="<c-k>"
	let g:UltiSnipsJumpBackwardTrigger="<c-b>"
"}}}

"alguns autocmd------------------{{{
    " retornar o cursor a posição em que estava quando fecho o arquivo
    autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
        \| exe "normal! g'\"" | endif
"}}}

" alguns maps -----------------{{{
:nnoremap <space> viw

:nnoremap <enter> o<Esc>

"troca o modo dos numeros
map <leader>l :set relativenumber!<CR>


"map para auto ident
nnoremap <leader><TAB> mmgg=G`m

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

:noremap  <F9> <C-O>:call ChangeKeyboard()<CR>


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
		autocmd FileType tex :setlocal spell spelllang=pt
    augroup END
"}}}

"gvim-----------------{{{
    set guifont=Monospace\ 12
"}}}

"conf de temas ------------------ {{{
"let g:gruvbox_italic=1
set background=dark
if &term =~ "linux"
    colorscheme crayon
    hi ExtraWhitespace ctermbg=blue
else
    colorscheme PaperColor
    hi ExtraWhitespace ctermbg=red
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
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
augroup grupoC
    autocmd!
    autocmd BufRead,BufNewFile *.c set filetype=c.doxygen
    autocmd FileType c,c.doxygen,cuda :inoremap <buffer> <leader>i <Esc>I#include <<Esc>A.h>
    autocmd FileType c,c.doxygen,cuda :inoremap <buffer> <leader>I <Esc>I#include "<Esc>A.h"
    "autocmd FileType c,c.doxygen :let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
augroup END

augroup grupoCPP
    autocmd!
	" make the get and set prototype
    autocmd FileType cpp :nnoremap <buffer> <leader>p ma$"nyb$F "yy^/getters<CR>o<esc>xxa<c-r>y <c-r>n<esc>F l~F aget<esc>A() const;<esc>/setters<CR>o<esc>xxavoid <c-r>n<esc>F l~F aset<esc>A(<c-r>y <c-r>n);<esc>'aj:noh<CR>
	" make the get and set function
    autocmd FileType cpp :nnoremap <buffer> <leader>P ma$"nyb$F "yy^?class <CR>w"cyeGo<c-r>y <c-r>n<esc>F l~F a<c-r>c::get<esc>A() const{<CR>return this-><c-r>n;<CR>}<CR><esc>3k"fd4d:let @G=@f<CR>ovoid <c-r>n<esc>F l~F a<c-r>c::set<esc>A(<c-r>y <c-r>n){<CR>this-><c-r>n = <c-r>n;<CR>}<CR><esc>3k"fd4d:let @S=@f<CR>'aj:noh<CR>:w<CR>
	" write include with <>
    autocmd FileType cpp :inoremap <buffer> <leader>i <Esc>I#include <<Esc>A>
	" write include with \"\"
    autocmd FileType cpp :inoremap <buffer> <leader>I <Esc>I#include "<Esc>A.hpp"
augroup END

augroup grupoCPPeC
    autocmd!
    autocmd FileType c,c.doxygen,cpp,cuda :iabbrev <buffer> imain int main (int argc , char* argv[]){<Enter>return 0;<Enter>}<up><up><end><Enter>
    autocmd FileType c,c.doxygen,cpp,cuda :let @s=''
    autocmd FileType c,c.doxygen,cpp,cuda :let @g=''
    autocmd FileType c,c.doxygen,cpp,cuda :nnoremap <buffer> <leader>g I//<Esc>
    autocmd FileType c,c.doxygen,cpp,cuda :inoremap <buffer> <leader>g <Esc>mnI//<Esc>'n
    autocmd FileType c,c.doxygen,cpp,cuda :vnoremap <buffer> <leader>g <Esc>`<i/*<Esc>`>a*/<Esc>
    autocmd FileType c,c.doxygen,cpp,cuda :let &path="lib,"
	autocmd FileType c,c.doxygen,cpp,cuda :set foldmethod=manual
	autocmd FileType c,c.doxygen,cpp,cuda :nnoremap <buffer> çf Va{zf
"}
augroup END




"}}}

"autocmd xml e html ------------{{{
	" these autocmd auto close tag in xml and html
	"this commando don't work with asyncComplete
    "autocmd FileType html,xml :inoremap <buffer> </ </<C-X><C-O><Esc>mb==`ba
	"this work with asynComplete
    autocmd FileType html,xml :inoremap <buffer> </ </<C-X><C-O><C-P><C-P><Esc>mb==`ba
"}}}

"txt --------------- {{{
    autocmd FileType txt,text :set tw=100
"}}}

"javascript ----------{{{
	autocmd FileType javascript :set foldmethod=expr foldexpr=lsp#ui#vim#folding#foldexpr()
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
:function ChangeKeyboard()
	echom "fui chamado"
	if  substitute(system("setxkbmap -query | grep variant | sed  's/\\s\\+/ /' | cut -d ' ' -f 2"), '\n$', '', '') == "dvorak"
		set langmap=xq,\\,w,.e,pr,yt,fy,gu,ci,ro,lp,=[,aa,os,ed,uf,ig,dh,hj,tk,nl,sç,-],\\;z,qx,jc,kv,xb,bn,mm,w\\,,v.,z\\;,\\\\\\,<W,?Q,>E,PR,YT,FY,GU,CI,RO,LP,+{,AA,OS,ED,UF,IG,DH,HJ,TK,NL,SÇ,_},:Z,QX,JC,KV,XB,BN,MM,W<,V.,Z:
		set nolangremap
	else
		set langmap&
	endif
:endfunction

