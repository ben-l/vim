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

"autocomplete package (install ncurses5-compat-libs with a aur package manager -
"otherwise ymcd server will not start as libtinfo.so.5 is missing)
"also see the below code for setting the ycm conf file
Plugin 'ycm-core/YouCompleteMe'

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


"add this line to .vimrc after loading YCM; this sets the default location for
"ycm_extra_conf.py (needed for .c and .cpp extensions)
"Also if the YcmServer is unable to load cd into ~/.vim/bundle/YouCompleteMe/
"and ./install.py --clang-completer
"./install.py --all for autocomplete to be used for most languages including
"go, rust, c#, javascript etc.

let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
"ycm error highlighting colors - red for bg and white for fg
highlight YcmErrorSection ctermbg=1 ctermfg=15


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

" nnoremap <leader>h :wincmd h<CR>
" nnoremap <leader>j :wincmd j<CR> 
" nnoremap <leader>k :wincmd k<CR> 
" nnoremap <leader>l :wincmd l<CR>

"open nerdtree with the following remapping: \(leader)+nt
nnoremap <silent> <leader>nt :NERDTreeToggle<CR>
"enable icons in nerdtree as well as utf-8 support in general
set encoding=UTF-8
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1


"ctrlp settings (remapped to Ctrl-f because Ctrl-p is now for paste) 
"ctrl p buffer settings {tab number}gt
"nnoremap <silent> <C-f> :CtrlP<CR>
let g:ctrlp_map = '<c-f>'
let g:ctrlp_switch_buffer = 'Et' " If already opened jump to it
let g:ctrlp_use_caching = 0 " stop ctrlp caching so it scans new files automatically
" let g:ctrlp_show_hidden = 1 "show hidden files and directories
set wildignore+=*.a,*.o,*.out "ignore binaries
set wildignore+=*.bmp,,*.gif,*.ico,*.jpg,*.png,*.pdf "ignore images

"use urlview to choose and open a url
:noremap <leader>u :w<Home>silent <End> !urlview<CR>

" A syntax for placeholders. Pressing <Ctrl-j> jumps to the next match.
:inoremap <c-j> <Esc>/<++><CR><Esc>cf>
:vnoremap <c-j> <Esc>/<++><CR><Esc>cf>
" :map <c-j> <Esc>/<++><CR><Esc>cf>
"

" format/style settings
au BufNewFile,BufRead *.py,*.js,*.go,*.html,*.css,*.h,*.c,*.cpp,*.java,*.md,*.json
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


let python_highlight_all = 1

"--------------------**ALE**---------------------
"ale - stop having the linter run continuously, only after you save:
" let g:ale_lint_on_text_changed = 'never'
"ale - stop having the linter show errors upon opening a file:
" let g:ale_lint_on_enter = 0
let g:ale_linters = {'cpp': ['g++'], 'c': ['clang']}
let g:ale_completion_enabled = 1 "use ale's autocomplete instead of ycm
let g:ale_set_loclist=1
" or use vim's Ctrl-N to scan file for suggestions

"change the gutter bg colour from the default grey:
highlight SignColumn ctermbg=black

"disable highlighting with ale
let g:ale_set_highlights = 1
"highlight clear ALEErrorSign
" let g:ale_sign_error = '!'
"highlighting format:
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEError ctermbg=red  ctermfg=white
"highlight ALEStyleError ctermbg=red ctermfg=white
"highlight clear ALEWarningSign
let g:ale_sign_warning = '•'
"highlighting format:
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
highlight ALEWarning ctermbg=NONE ctermfg=NONE
" highlight ALEStyleWarning ctermbg=red ctermfg=yellow
nmap <silent> <leader>j :ALENext<cr>
nmap <silent> <leader>k :ALEPrevious<cr>

"stop ALE syntax checking on the following files:
autocmd BufEnter *.tex ALEDisable

let g:ale_set_loclist = 0
let g:ale_open_list = 0
let g:ale_set_quickfix = 0
"------------------------------------------------

"map autopep8 to \8
"au FileType python noremap <leader>8 :call Autopep8()<CR>
"let g:autopep8_disable_show_diff=1 " disable the pop up window

"trigger config. for snippets(ultisnips)
let g:UltiSnipsUsePythonVersion = 3
" let g:UltiSnipsSnippetDirectories=["UltiSnips"]
let g:UltiSnipsExpandTrigger="<C-x>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

nnoremap <buffer> <F9> :exec '!python' shellescape(@%, 1)<CR>

"flagging unnecessary Whitespace
highlight BadWhiteSpace ctermbg=red  guibg=red
:autocmd BufRead,BufNewFile *.py,*.pyw,*.c,*.h,*.go,*.cpp,*.hh match BadWhiteSpace /\s\+$/

" c++ max chars in a line
:autocmd BufRead,BufNewFile *.c,*.h,*.cpp,*.hh,*.a
						\ highlight OverLength ctermbg=red ctermfg=white guibg=#592929 |
						\ match OverLength /\%120v.\+/

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
