filetype off                   " required for Vundle
:set nocompatible              " required for Vundle
" set the runtime path to include Vundle and initialize
set rtp+={{ (ansible_user_dir, nvim_config_dir, 'bundle', 'Vundle.vim') | path_join }}
" source the plugin file
source {{ (ansible_user_dir, nvim_config_dir, nvim_plugin_file) | path_join }}

:set tabstop=4
:set shiftwidth=4
:set expandtab
:set hidden
:set number
:set relativenumber
:set clipboard=unnamedplus
:set nowrap
:set fixendofline
:let mapleader='ö'
:let maplocalleader='ö'
:set foldmethod=syntax
:set cursorline
nnoremap <space> za
:set foldlevel=120

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

:function! LoadSession()
:   let fpath = expand('%:p:h') . "/Session.vim"
:   if filereadable(fpath)
:       so Session.vim
:   endif
:endfunction

if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

silent! exec "call LoadSession()"

" Pysen
:au BufNewFile,BufRead *.py set tabstop=4 | set softtabstop=4 | set shiftwidth=4 | set textwidth=79 | set expandtab | set autoindent | set fileformat=unix | set foldmethod=indent
:au BufNewFile,BufRead *.yml set tabstop=2 | set softtabstop=2 | set shiftwidth=2 | set textwidth=79 | set expandtab | set autoindent | set fileformat=unix

:au BufNewFile,BufRead *.pt set tabstop=2 | set softtabstop=2 | set shiftwidth=2 | set expandtab | set autoindent | set fileformat=unix

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-W> <Esc>:bd <Enter> :<Esc>
:set shell=/bin/zsh
inoremap <C-J> <Esc>/<++><Enter>:noh<Enter>"_c4l
let g:ycm_server_python_interpreter = 'python3'

let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}
" Bindings for Rmarkdown files

:function! CompileRmd()
    :silent ! echo "require(rmarkdown); render('%')" | R --vanilla
:endfunction

autocmd BufWritePost *.rmd exec "call CompileRmd()"
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>


let g:ale_python_pylint_args = "--rcfile=\"" . join(systemlist("git rev-parse --show-toplevel")) . "/.pylintrc\""
let g:ale_fixers = {
\     'python': ['yapf',],
\     'cpp': ['clang-format',],
\     'dart': ['dartfmt',],
\}

let g:ale_cpp_clangtidy_extra_options = "-extra-arg=-std=c++20"
let g:ale_linters = {
\     'cpp': ['clangtidy'],
\}
let g:ale_fix_on_save = 1

" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"


" Control + P
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

nnoremap <C-f> :NERDTreeToggle<CR>
let g:airline#extensions#tabline#enabled = 1
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
let g:airline_powerline_fonts = 0
let g:airline_theme='gruvbox'
let g:airline_luna_bg='dark'
set t_Co=256
set laststatus=2
let g:airline_exclude_preview = 1

" Track the engine.
" Snippets are separated from the engine. Add this if you want them:
let g:ale_lint_on_text_changed = 'never'
let g:go_fmt_command = "goimports"    " Run goimports along gofmt on each save
let g:go_auto_type_info = 1           " Automatically get signature/type info for object under cursor
:augroup gogroup
    :au FileType go set fileformat=unix | set nolist
    :au FileType go nnoremap <leader>lr :GoRun<Enter>
    :au FileType go nnoremap <leader>li :GoInstall<Enter>
    :au FileType go nnoremap <leader>lt :GoTest<Enter>
    :au FileType go nnoremap <leader>lb :GoBuild<Enter>
    :au FileType go nnoremap <leader>ld :GoDoc<Enter>
    :au FileType go nnoremap <leader>lD :GoDocBrowser<Enter>
    :au FileType go nnoremap <leader>ll :GoMetaLinter<Enter>
:augroup END


autocmd FileType cpp setlocal commentstring=//\ %s



:let g:notes_directories = ['~/ownCloud/Notes']


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<Tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


" let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let $FZF_DEFAULT_OPTS='--reverse'

nnoremap <leader>gs :tab G<Enter><Esc>
nnoremap <leader>gd :G diff<Enter><Esc>
nnoremap <leader>gp :G push<Enter><Esc>
nnoremap <leader>gc :GCheckout<CR>

autocmd FileType gitcommit set completefunc=emoji#complete
autocmd FileType gitcommit set omnifunc=emoji#complete

let g:ale_sign_column_always = 1

let python_highlight_all =1
filetype plugin indent on       " required
syntax on

" colorscheme zenburn
" colorscheme dracula
colorscheme neodark
" colorscheme gruvbox
" colorscheme PaperColor
set background=dark

:function! CompileRmd()
    :silent ! echo "require(rmarkdown); render('%')" | R --vanilla
:endfunction

:function! ServeHugo()
    :silent ! ~/.config/nvim/serve-hugo-locally.sh $(git rev-parse --show-toplevel)
    :autocmd VimLeave * ! pkill hugo
:endfunction

set list          " Display unprintable characters f12 - switches
set listchars=tab:•\ ,trail:•,extends:»,precedes:« " Unprintable chars mapping
autocmd BufWritePost *.rmd exec "call CompileRmd()"

autocmd BufWritePre * exec "retab"
autocmd BufWritePre *.tex,*.py %s/\s\+$//e
" autocmd BufWritePre *.tex,*.pt,*.py,*.sh,*.cc,*.cpp,*.cu,*.js %s/\s\+$//e
autocmd VimLeave *.tex <LocalLeader>lc<Enter>

autocmd Filetype markdown map <F5> :!pandoc<space><C-r>%<space>-o<space><C-r>%.pdf<Enter><Enter>

" lervag/vimtex
if !exists('g:ycm_semantic_triggers')
    let g:ycm_semantic_triggers = {}
endif

let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
let g:vimtex_view_method = 'zathura'
let g:vimtex_imaps_leader = "'"
let g:vimtex_complete_close_braces=1
let g:tex_flavor='latex'
let g:vimtex_fold_enabled = 1
let g:Tex_IgnoredWarnings = 'Overfull'."\n"
let g:Tex_IgnoreLevel = 8
