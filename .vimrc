set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'

Plugin 'autozimu/LanguageClient-neovim'
Plugin 'Shougo/deoplete.nvim'
Plugin 'tweekmonster/deoplete-clang2'

Plugin 'jalvesaq/vimcmdline'

" Giggles
Plugin 'fszymanski/deoplete-emoji'
call vundle#end()            " required

let g:LanguageClient_serverCommands = {
  \ 'haskell': ['hie', '--lsp'],
  \ 'python': ['pyls'],
  \ "javascript": ['node', '/Users/jonval/WARNING/LSPS/javascript-typescript-langserver/lib/language-server-stdio.js'],
\}

let g:deoplete#enable_at_startup = 1

nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>


set backupdir=/Users/jonval/.backups
set directory=/Users/jonval/.backups


let g:disable_vim_auto_close_plugin = 1
"Global sets
set laststatus=1
set statusline=%f\ %y

let g:deoplete#enable_at_startup = 1

let g:netrw_altv=1
let g:netrw_preview   = 1
let g:netrw_liststyle = 3
let g:netrw_winsize   = 75

let cmdline_follow_colorscheme = 1
let cmdline_vsplit      = 1      " Split the window vertically
let cmdline_map_start          = '<C-i>'
let cmdline_map_send_and_stay  = '<C-s>'
let cmdline_map_send           = '<C-s>'

set encoding=utf-8
set clipboard+=unnamed,unnamedplus
set nocompatible "Not sure what it does but people claim its useful"
set path=~/ "Path to root"
set mouse=a "enable mouse"

"Switching Buffers without saving
set hidden

"For Regexes
set magic

"Fix Searching
set hlsearch "Highligh search hits"
set incsearch "Not sure"

set completeopt-=preview "Remove Preview window when completing"
set sh=/bin/zsh "Shell to use"
" not sure set ef=e.err
set title "Enable Title on window"


set wildmenu "Autocompletion in commandline"
set wildmode=longest:full,full "How to autocomplete"
set wildignore+=*/target/*,*/.git/*,*/node_modules/* "What autocomplete ignores"
set tagstack "Enables Stack for tags"
set autoread "Not Sure But useful apparently"

set showmatch

"Default Indentation
set tabstop=2 "not sure"
set shiftwidth=2  "tab width"
set expandtab "Convert tab to spaces"
set ai "Keeps indentation from last line"

"autocmd BufReadPre,BufNewFile * let b:did_ftplugin = 1

set termguicolors
colo mycolo


let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"

syntax on
filetype plugin indent on

if has("nvim")
  nnoremap <C-space> <C-^>`"zz
  nnoremap <leader><C-space> :vertical sbp<CR>`"zz
else
  map <C-@> <C-^>`"zz
  map <leader><C-@> :vertical sbp<CR>`"zz
endif

inoremap (<CR> ()<Esc>i
inoremap {<CR> {<CR>}<Esc>O
inoremap {; {<CR>};<Esc>O
inoremap {, {<CR>},<Esc>O
inoremap [<CR> []<Esc>i
inoremap [; [];<Esc>i<Esc>i
inoremap [, [],<Esc>i<Esc>i

map <space> <leader>
imap <tab> <C-n>
map <C-b> :b 
map <leader><C-b> :vertical sb 
map <C-d> :bd<CR>
map <C-e> :Explore<CR>
map s /
map ö }
map ä {
map Y 0y$
map R :%s//

"stty -ixon IS NEEDED FOR C-s binding put in *rc
nnoremap gs :RecursiveSearchCursorWord<CR>

nnoremap <F2> :silent! Make<CR>

highlight QuickFixLine term=bold,underline cterm=bold,underline gui=bold,underline


nnoremap <expr> <C-n> &diff ? ']c' : ':cn<CR>'
nnoremap <expr> <C-p> &diff ? '[c' : ':cp<CR>'
nnoremap <expr> dd &diff ? ':diffget<CR>' : 'dd'
nnoremap <expr> ds &diff ? ':diffput<CR>' : '<CR>'
vnoremap <expr> dd &diff ? ':diffget<CR>' : 'dd'
vnoremap <expr> ds &diff ? ':diffput<CR>' : '<CR>'


command! Make execute "make " . expand("%") . " | redraw!"
command! -nargs=1 Search execute "vimgrep /" . <q-args> . "/j *"
command! -nargs=1 RecursiveSearch execute "vimgrep /" . <q-args> . "/j **"
command! RecursiveSearchCursorWord call Searches("vimgrep /" . expand("<cword>") . "/j **/*.%:e", expand("<cword>")) 

command! Vterm execute "vsplit |term"

let g:pat = "Hell"

function Searches(searchcmd, searchpattern)
  execute a:searchcmd
  call MatchHL(a:searchpattern)
endfunction

function MatchHL(matches)
  let g:pat = matchadd("QuickFixLine", a:matches)
endfunction

function MatchRM()
  call matchdelete(g:pat)
endfunction

  

au FileType netrw setl bufhidden=delete
