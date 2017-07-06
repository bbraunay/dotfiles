set nocompatible              " required
" filetype off                  " required
filetype indent plugin on
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
Plugin 'gmarik/Vundle.vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/YouCompleteMe'
Plugin 'majutsushi/tagbar'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

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
set clipboard=unnamedplus

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
"au BufRead,BufNewFile *.html, *.css
"    \ set tabstop=2 |
"    \ set softtabstop=2 |
"    \ set shiftwidth=2

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

" Full stack setting for tab and spaces
au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2
    \ set softtabstop=2
    \ set shiftwidth=2

" YouCompleteMe settings
let g:ycm_server_python_interpreter = '/usr/bin/python3'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files = 1 " Let YCM read tags from Ctags file
let g:ycm_use_ultisnips_completer = 1 " Default 1, just ensure
let g:ycm_seed_identifiers_with_syntax = 1 " Completion for programming language's keyword
let g:ycm_complete_in_comments = 1 " Completion in comments
let g:ycm_complete_in_strings = 1 " Completion in string
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_keep_logfiles = 1
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
 
" Python with virtualenv support
"python3 << EOF
"import os
"import sys
"
"if 'VIRTUAL_ENV' in os.environ:
"  project_base_dir = os.environ['VIRTUAL_ENV']
"  activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
"  exec(compile(open(activate_this).read(), activate_this, 'exec'), dict(__file__=activate_this))
"EOF

python3 << EOF
import os

DJANGO_SETTINGS_MODULE = 'psc.settings'
virtualenv = os.environ.get('VIRTUAL_ENV')
if virtualenv:
    activate_this = os.path.join(virtualenv, 'bin', 'activate_this.py')
    exec(compile(open(activate_this).read(), activate_this, 'exec'), {'__file__': activate_this})
    os.environ['DJANGO_SETTINGS_MODULE'] = DJANGO_SETTINGS_MODULE
EOF

" Syntastic settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_loc_list_height=3
