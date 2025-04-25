"" Set mapleader to space
let mapleader = " "

"both are required for Vundle and should be at the top of the .vimrc file
set nocompatible 
set pastetoggle=<F3>

"set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim
"keep Plugin commands between vundle#begin/end
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" navigate between vim and tmux splits
Plugin 'christoomey/vim-tmux-navigator'

"syntax checking
Plugin 'w0rp/ale'

" produce templates/snippets for definitions, functions etc
Plugin 'SirVer/ultisnips'
" snippets are separate from the engine. Add the following if needed:
" see below for trigger configuration
Plugin 'honza/vim-snippets'

"file tree
Plugin 'scrooloose/nerdtree'

" a git wrapper
Plugin 'tpope/vim-fugitive'

"search files with the ctrl-p program
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'junegunn/fzf.vim'

"surround text with parentheses, brackets, quotes, tags etc
Plugin 'tpope/vim-surround'

"icons for nerdtree and ctrlp
Plugin 'ryanoasis/vim-devicons'

"latex live preview
Plugin 'xuhdev/vim-latex-live-preview'

"javascript
Plugin 'pangloss/vim-javascript'

"markdown
Plugin 'plasticboy/vim-markdown'

"Live Preview for markdown
" (need npm installed) npm install -g livedown
Plugin 'shime/vim-livedown'

"docker syntax highlighting & snippets
Plugin 'ekalinin/Dockerfile.vim' 
"docker-compose syntax highlighting
Plugin 'stephpy/vim-yaml' 


"All of your Plugins must be added before the following line:
call vundle#end()		" required
filetype plugin on
filetype plugin indent on	" required
syntax on

" disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif



" ripgrep with Fzf
command! -nargs=* Rg call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

nnoremap <leader>fg :Rg<space>

" Open a new tab with <leader>te
nnoremap <leader>te :tabedit<CR>

" Move to next tab with Tab
nnoremap <Tab> :tabnext<CR>

" Move to previous tab with Shift-Tab
nnoremap <S-Tab> :tabprevious<CR>

" Split Horizontal
nnoremap <leader>sx :split<CR>

" Split Vertical
nnoremap <leader>sv :vsplit<CR>

" Open an interactive bash shell with <leader>sh
nnoremap <leader>sh :sh<CR>

" must be compiled with +terminal support
" :echo has('terminal')
" output: 1=yes 0=no
" Open terminal in split horizontal
nnoremap <leader>tx :horizontal terminal<CR>

" Open terminal in split vertical
nnoremap <leader>tv :vertical terminal<CR>

" Open terminal in new tab
nnoremap <leader>tt :tab terminal<CR>

" remapping: nmap(normal mode) vmap(visual) imap(insert mode).
" the 'nore' is to prevent looping
"
" for vim-livedown markdown preview, launch/kill the livedown server
nnoremap <silent> <leader>mt :LivedownToggle<CR>

" copy and paste shortcuts for system clipboard
" vnoremap <C-y> "+y (commented because the *y line is uncommented) 
map <C-p> "*P
" for copying to both the clipboard and primary selection (to paste into st from vim this is required)
vnoremap <C-y> "*y :let @+=@*<CR>

"Enable Folding
set nofoldenable

" show line numbers
set nu 

"paste from system clipboard
noremap <Leader>p "+p

"copy to system clipboard
noremap <Leader>y "+y

" navigate windows
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <C-+> :vertical resize +5<CR>
nnoremap <C--> :vertical resize -5<CR>


"open nerdtree with the following remapping: (leader)+nt
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
"enable icons in nerdtree as well as utf-8 support in general
set encoding=UTF-8
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1


"ctrlp settings (remapped to Ctrl-f because Ctrl-p is now for paste) 
"ctrl p buffer settings {tab number}gt
"nnoremap <silent> <C-f> :CtrlP<CR>
let g:ctrlp_map = '<leader>ff'
let g:ctrlp_switch_buffer = 'Et' " If already opened jump to it
let g:ctrlp_use_caching = 0 " stop ctrlp caching so it scans new files automatically
let g:ctrlp_show_hidden = 1 "show hidden files and directories
set wildignore+=*.a,*.o,*.out "ignore binaries
set wildignore+=*.bmp,,*.gif,*.ico,*.jpg,*.png,*.pdf "ignore images

" A syntax for placeholders. Pressing <Ctrl-j> jumps to the next match.
:inoremap <c-j> <Esc>/<++><CR><Esc>cf>
:vnoremap <c-j> <Esc>/<++><CR><Esc>cf>
" :map <c-j> <Esc>/<++><CR><Esc>cf>
"

" format/style settings
au BufNewFile,BufRead *.py,*.js,*.go,*.html,*.css,*.h,*.c,*.cpp,*.java,*.md,*.json,*.txt,*.glsl
	\ set tabstop=4   |
	\ set softtabstop=4 |
	\ set shiftwidth=4 |
	\ set textwidth=120 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix 

au BufNewFile,BufRead *.yml,*.tf
	\ set tabstop=2   |
	\ set softtabstop=2 |
	\ set shiftwidth=2 |
	\ set textwidth=120 |
	\ set expandtab |
	\ set autoindent |
	\ set fileformat=unix 


"--------------------**ALE**---------------------
" ale - stop having the linter run continuously, only after you save:
" let g:ale_lint_on_text_changed = 'never'
" ale - stop having the linter show errors upon opening a file:
" let g:ale_lint_on_enter = 0
let g:ale_linters = {'cpp': ['g++'], 'c': ['clang']}
let g:ale_completion_enabled = 1 "use ale's autocomplete instead of ycm
let g:ale_set_loclist=1
" or use vim's Ctrl-N to scan file for suggestions
"
" change the gutter bg colour from the default grey:
highlight SignColumn ctermbg=black
" disable highlighting with ale
" let g:ale_set_highlights = 1
" highlight clear ALEErrorSign
" let g:ale_sign_error = '!'
" highlighting format:
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEError ctermbg=red  ctermfg=white
" highlight ALEStyleError ctermbg=red ctermfg=white
" highlight clear ALEWarningSign
let g:ale_sign_warning = '•'
" highlighting format:
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEWarning ctermbg=NONE ctermfg=NONE
" highlight ALEStyleWarning ctermbg=red ctermfg=yellow
nmap <silent> <leader>j :ALENext<cr>
nmap <silent> <leader>k :ALEPrevious<cr>
"
" stop ALE syntax checking on the following files:
autocmd BufEnter *.tex ALEDisable
let g:ale_set_loclist = 0
let g:ale_open_list = 0
let g:ale_set_quickfix = 0
" ------------------------------------------------

"trigger config. for snippets(ultisnips)
let g:UltiSnipsUsePythonVersion = 3
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<C-x>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"


"for latex live preview (default pdfviewer)
" for some extra latex packages install texlive-latexextra
let g:livepreview_previewer = 'zathura'
nnoremap <silent> <leader>sp :LLPStartPreview<CR>

" "C++ Class Generator                                                                                                    
" e.g. :call Class("testclass")
 function! Class(ClassName)                                                                                              
    "==================  editing header file =====================                                                       
     let header = a:ClassName.".h"                                                                                                                                                                                                                                                                                        
     :vsp %:h/.h                                                                                                                                                                                                                             
     call append(0,"#ifndef ".toupper(a:ClassName)."_H")                                                                 
     call append(1,"#define ".toupper(a:ClassName)."_H")                                                           
     call append(2," ")                                                                                                  
     call append(3,"class ".a:ClassName )                                                                                
     call append(4, "{")                                                                                                 
     call append(5, "   public:")                                                                                        
     call append(6, "      ".a:ClassName."();")                                                                          
     call append(7, "      virtual ~".a:ClassName."();")                                                                 
     call append(8, "   protected:")                                                                                     
     call append(9, "   private:")                                                                                       
     call append(10, "};")                                                                                               
     call append(11,"#endif // ".toupper(a:ClassName)."_H")                                                              
     :execute 'write' header                                                                                             
   "================== editing source file ========================                                                      
     let src    = a:ClassName.".cpp"                                                                                     
     :vsp %:h/.cpp                                                                                                                                                                                                                     
     call append(0,"#include ".a:ClassName.".h")                                                                          
     call append(1," ")                                                                                                   
     call append(2,a:ClassName."::".a:ClassName."()")                                                                           
     call append(3,"{")                                                                                                   
     call append(4,"//ctor ")                                                                                             
     call append(5,"}")                                                                                                   
     call append(6," ")                                                                                                   
     call append(7," ")                                                                                                   
     call append(8,a:ClassName."::~".a:ClassName."()")                                                                         
     call append(9,"{")                                                                                                   
     call append(10,"//dtor ")                                                                                            
     call append(11,"}")                                                                                                  
     :execute 'write' src
endfunction
