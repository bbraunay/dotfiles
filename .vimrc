set nocompatible              " required
filetype off                  " required
set noswapfile		      " no swap file created
set t_Co=256		      " set 256 color
let &colorcolumn=join(range(81,999),",")  " colorcolumn highlight
hi ColorColumn guibg=#2c2d27 ctermbg=235
 
" Set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Alternatively, pass a path where Vundle should install plugins
" Call vundle#begin('~/some/path/here')

" Let Vundle manage Vundle, required
Plugin 'w0rp/ale'
Plugin 'VundleVim/Vundle.vim'
" Plugin 'tmhedberg/SimpylFold'
" Plugin 'vim-syntastic/syntastic'
" Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
" Plugin 'honza/vim-snippets'
Plugin 'fatih/vim-go'

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)


" All of your Plugins must be added before the following line
call vundle#end()            " required

" General settings
filetype on
filetype plugin on
filetype plugin indent on
set cursorline                              " shows line under the cursor's line
set showmatch                               " shows matching part of bracket pairs (), [], {}
set backspace=indent,eol,start              " backspace removes all (indents, EOLs, start) What is start?

" Search settings
set incsearch	                            " incremental search
set hlsearch	                            " highlight search results

" Enable system clipboard in linux
set clipboard=unnamed

" Set new split to below or right
" set splitbelow
set splitright

" Split navigations in normal mode
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Enable folding with the spacebar
nnoremap <space> za

" SimplyFold settings
let g:SimpylFold_docstring_preview=1

" Syntastic and syntac settings
let python_highlight_all=1
syntax on

" Full dev setting for files
au BufRead,BufNewFile *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" Flagging unnecessary whitespace red
highlight BadWhitespace ctermbg=red guibg=red					"" Turn on highlight for BadWhitespace
au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/		"" Match whitespace in order to be highlighted
au BufRead,BufNewFile *.py,*.pyw match BadWhitespace /^\t\+/			"" Highlight beginning tab

" Set encoding UTF-8
set encoding=utf-8

" Set number and relative numbering
set number
set relativenumber

" Airline settings
set laststatus=2
" let g:airline_theme='solarized'
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#formatter='unique_tail'
let g:airline_powerline_fonts=1

" NERDTree settings
let NERDTreeIgnore=['\.pyc$', '\.pyo$', '__pycache__$']     " Ignore files in NERDTree
let NERDTreeWinSize=30
autocmd VimEnter * if !argc() | NERDTree | endif  " Load NERDTree only if vim is run without arguments
nmap " :NERDTreeToggle<CR>

" Auto indent pep for python file
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

" YouCompleteMe settings
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger       = "<c-j>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-p>"
let g:UltiSnipsListSnippets        = "<c-k>" 

" TagBar settings
let g:tagbar_autofocus=0
let g:tagbar_width=35
" autocmd BufEnter *.py :call tagbar#autoopen(0)
" autocmd BufWinLeave *.py :TagbarClose
nmap <F8> :TagbarToggle<CR>

" Syntastic options
" let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes':   [],'passive_filetypes': [] }
" let g:syntastic_python_checkers = ['pylint']
" let g:syntastic_check_on_open = 0
" noremap <C-w>e :SyntasticCheck<CR>
" noremap <C-w>f :SyntasticToggleMode<CR>

" Ale config
" Check Python files with flake8 and pylint.
let g:ale_linters = {'python': ['flake8']}
" Fix Python files with autopep8 and yapf.
let g:ale_fixers = {'python': ['autopep8']}
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1

" Python with pipenv support
let pipenv_venv_path = system('pipenv --venv')
if shell_error == 0
  let venv_path = substitute(pipenv_venv_path, '\n', '', '')
  let g:ycm_server_python_interpreter = venv_path . '/bin/python'
else
  let g:ycm_server_python_interpreter = 'python'
endif
