"" Set mapleader to space
let mapleader = " "

"both are required for Vundle and should be at the top of the .vimrc file
set nocompatible 
filetype off
set pastetoggle=<F3>


"set the runtime path to include Vundle and initialize
"keep Plugin commands between vundle#begin/end
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

"let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" navigate between vim and tmux splits
Plugin 'christoomey/vim-tmux-navigator'

" gruvbox colorscheme
Plugin 'morhetz/gruvbox'

"syntax checking
Plugin 'w0rp/ale'

" snippets are separate from the engine. Add the following if needed:
" see below for trigger configuration
Plugin 'honza/vim-snippets'

"file tree
Plugin 'scrooloose/nerdtree'

" a git wrapper
Plugin 'tpope/vim-fugitive'

"search files with the ctrl-p program
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'junegunn/fzf'
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
"Plugin 'plasticboy/vim-markdown'

"Live Preview for markdown
" (need npm installed) npm install -g livedown
Plugin 'shime/vim-livedown'

"docker syntax highlighting & snippets
Plugin 'ekalinin/Dockerfile.vim' 
"docker-compose syntax highlighting
Plugin 'stephpy/vim-yaml' 


"Plugins must be added before the following line:
call vundle#end()		" required
filetype plugin indent on	" required
syntax on

set background=dark
colorscheme gruvbox

" disable beeps
set noerrorbells visualbell t_vb=
if has('autocmd')
	autocmd GUIEnter * set visualbell t_vb=
endif

" IMPORTANT: set vimwiki config BEFORE end
let g:vimwiki_list = [{
  \ 'path': expand('~/documents/vimwiki/'),
  \ 'syntax': 'default',
  \ 'ext': '.wiki'
\ }]


" ripgrep with Fzf
command! -nargs=* Rg call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

"search for ripgrep
nnoremap <leader>fg :Rg<space>

" Open a new tab with <leader>te
nnoremap <leader>te :tabedit<CR>

" Move to next tab with Tab
nnoremap <Tab> :tabnext<CR>

" Move to previous tab with Shift-Tab
nnoremap <Esc>[Z :tabprevious<CR>

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
	\ setlocal tabstop=4   |
	\ setlocal softtabstop=4 |
	\ setlocal shiftwidth=4 |
	\ setlocal textwidth=120 |
	\ setlocal expandtab |
	\ setlocal autoindent |
	\ setlocal fileformats=unix

au BufNewFile,BufRead *.yml,*.tf
	\ setlocal tabstop=2   |
	\ setlocal softtabstop=2 |
	\ setlocal shiftwidth=2 |
	\ setlocal textwidth=120 |
	\ setlocal expandtab |
	\ setlocal autoindent |
	\ setlocal fileformats=unix


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

"for latex live preview (default pdfviewer)
" for some extra latex packages install texlive-latexextra
let g:livepreview_previewer = 'zathura'
nnoremap <silent> <leader>sp :LLPStartPreview<CR>
