" Todo: test2
" fuzzy headers for makeshift TOC
" quickfix headers :vimgrep /^#/ %
" Have quickfix automatically populate?

" leader key
let mapleader = "\<space>"
"let g:loaded_python3_provider = 0

command! -bang Args call fzf#run(fzf#wrap('args',
    \ {'source': map([argidx()]+(argidx()==0?[]:range(argc())[0:argidx()-1])+range(argc())[argidx()+1:], 'argv(v:val)')}, <bang>0))

set fileformat=unix
" Move line: shift-v, alt-j alt-k

" Buffers
nnoremap gb :buffers<cr>:buffer<space>
" nnoremap <leader>b :buffer <c-z>
nnoremap <pageup>   :bprevious<cr>
nnoremap <pagedown> :bnext<cr>
nnoremap <leader>b :Buffers <C-R>=expand('%:h')<cr><cr>

" Copy current file and path to buffer
nnoremap <leader>cp :let @+=expand("%:p")<CR>
"Tags
set tags=./tags;/

" File Navigation
"command! -bang -nargs=? -complete=dir fzcd :call 
"
command! -nargs=* -complete=dir Cd call fzf#run(fzf#wrap(
  \ {'source': 'find '.(empty(<f-args>) ? '.' : <f-args>).' -type d',
  \  'sink': 'cd'}))

" Find files
" https://stackoverflow.com/questions/61534650/fzf-like-way-to-quickly-change-into-a-directory-include-hidden-files-in-vim-fzf
" https://stackoverflow.com/questions/59111740/fzf-vim-changing-working-directory-on-the-fly
command! -nargs=? -complete=dir AF
  \ call fzf#run(fzf#wrap(fzf#vim#with_preview({
  \   'source': 'fdfind --type f --hidden --follow --exclude .git --no-ignore . '.expand(<q-args>)
  \ })))


" Find todos
nnoremap <leader>t :noautocmd :cd ~/vimwiki \| vimgrep /\<^#TODO\>/j *.md \| :cope<cr>
":com FindTODO :noautocmd vimgrep /\<todo\>/j *.md | :cope
nnoremap <leader>ft :noautocmd :cd ~/vimwiki \| :Ag #todo<cr>
 
" Function: Fztodo 
command! -bang -nargs=? -complete=dir Fzt :call fzf#vim#ag_raw('\#todo ' . ' ~/vimwiki/' , fzf#vim#with_preview(), <bang>0)


" Function: FZF Backlinks 
command! -bang -nargs=? -complete=dir Fzb call fzf#vim#ag_raw(expand('%:r') . ' ~/vimwiki/' , fzf#vim#with_preview(), <bang>0)


" Function: find backlinks to current file and open quickfix list with the results
command! Backlinks VimwikiBacklinks


" Quotes around word
nnoremap <leader>" viw<esc>a"<esc>hbi"<esc>lel

"Calendar
nnoremap <leader>c :calendar -view=month  -split=horizontal -position=below -height=12<cr>
nnoremap <leader>cf :calendart<cr>

" Dashboard keybindings
nmap <leader>ss :<c-u>sessionsave<cr>
nmap <leader>sl :<c-u>sessionload<cr>
nnoremap <silent> <leader>fh :DashboardFindHistory<cr>
" nnoremap <silent> <leader>dff :DashboardFindFile<cr>
nnoremap <silent> <leader>cc :DashboardChangeColorscheme<cr>
" dfw same as fw
" nnoremap <silent> <leader>dfw :DashboardFindWord<cr>
nnoremap <silent> <leader>fj :DashboardJumpMarks<cr>
nnoremap <silent> <leader>nf :DashboardNewFile<cr>

" Find files using telescope (Not currently installed)
" nnoremap <leader>tf :Telescope find_files<cr>
" nnoremap <leader>tw :Telescope live_grep<cr>
" nnoremap <leader>tb :Telescope buffers<cr>
" nnoremap <leader>tt :Telescope help_tags<cr>

" Escape
imap ;; <esc>
imap kj <esc>
imap ii <esc>
imap jj <esc>

" autocmd vimenter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | dashboard | endif

" Directory get location of current
nnoremap <leader>d <cmd>echo expand('%:p')<cr>

" Directory changes to directory the file that is open
nnoremap <leader>cd :cd %:p:h<cr>:pwd<cr>

" Escape use control-c
nnoremap <c-c> <esc>


" Pasting after cutting, keeps same word in paste buffer.
vnoremap p "_dp

" Save in normal mode
nnoremap <leader>w :w<cr>
" Save in insert mode
inoremap <c-s> <esc>:w<cr>
" Save and quit insert mode
inoremap <c-q> <esc>:wq!<cr>

" Tabs quickly rotate through
nnoremap tk :tabnext<cr>
nnoremap tj :tabfirst<cr>

" Tab completion.
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

" Tabbing better
vnoremap < <gv
vnoremap > >gv
" Todo change buffer remaps because of conflict with vimwiki
set iskeyword+=-                                                                            " to treat dash as part of word for easier navigation and deletion

" Terminal open below
nnoremap <c-t> :split term://bash<cr>

" Searching
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git
endif

au! bufwritepost $myvimrc source %                                                          " auto source when writing to init.vm alternatively you can run :source $myvimrc



" Manage swap files more efficientlyj
  "* mkdir ~/.vim/swapfiles
set directory=$home/.vim/swapfiles//                                                        " // tells vim to use absolute path

" Manage undo more efficiently; see also :help undo
" mkdir ~/.vim/undodirectory
set undodir=~/.vim/undodirectory
set undofile

" Executing. maps f5 to execute word under cursor then print output below
map <f5> yyp!!sh<cr><esc>


" Date/timestamp
imap <f3> <c-r>=strftime("%y-%m-%d %a %i:%m %p")<cr>
nmap <f3> i<c-r>=strftime("%y-%m-%d %a %i:%m %p")<cr><esc>

" Macros easier. qq to record and q to stop
"nnoremap q @q
" vnoremap q :norm @q<cr>

" NerdTree Toggle
nnoremap <leader>e  :NERDTreeToggle<cr>
" Search unsets the "last search pattern" register by hitting return
nnoremap <cr> :noh<cr><cr>

" Select all
map <leader>a ggvg
inoremap <c-v> <esc>"+pa

" Vimrc in new tab
nnoremap <leader>v :tabnew ~/.vimrc<cr>

" Vimrc in vertical split
nnoremap <leader>vs :vsplit ~/.vimrc<cr>

"Vimrc source
nnoremap <leader>s :source ~/.vimrc<cr>

" Vimwiki keybindings
nnoremap <leader>i :tabnew ~/vimwiki/100_Index.md<cr>
nnoremap <leader>is :vsplit ~/vimwiki/100_Index.md<cr>

nnoremap <leader>ls :vimwikivsplitlink

" Search Vimwiki
nnoremap <leader>sw :cd ~/vimwiki \| :Ag<cr>

" Window pane navigation splits more vim-like
nnoremap <c-h> <c-w><c-h>
nnoremap <c-j> <c-w><c-j>
nnoremap <c-k> <c-w><c-k>
nnoremap <c-l> <c-w><c-l>

" Window open in right
nnoremap <leader>r :vsplit<cr>

" Copies like windows from vim to windows
vnoremap <c-c> "+y

" nnoremap <leader>bl :ngrepl<cr><cr>

" Standard settings
filetype plugin on
filetype indent on
packloadall
set autochdir
" your working directory will always be the same as your working directory
set autoindent
" new lines inherit indentation of previous lines
set backspace=indent,eol,start
" backspace over everything in insert mode
set background=dark
" tell vim what the background color looks like
set complete+=kspell
"  autocomplete spellcheck
set completeopt=menu,longest,preview
set conceallevel=0
" so that i can see `` in markdown files
set confirm
" displays confirm message when closing unsaved file
set cindent
set clipboard=unnamedplus
" copy paste between vim and everything else
set cmdheight=2
" more space for displaying messages
set cursorline
" enable highlighting of the current line
set encoding=utf-8
" the encoding displayed
set expandtab
" converts tabs to spaces
set modifiable
" allows to delete files in nerdtree
set fileencoding=utf-8
" the encoding written to file
set formatoptions-=cro
" stop newline continution of comments
set hidden
" required to keep multiple buffers open multiple buffers
set hlsearch
"  set highlight search. type :noh to temporarily turn off hlsearch
set ignorecase
" ignore case
set incsearch
set iskeyword+=-
" treat dash separated words as a word text object"
set laststatus=2
" always display the status line; to disable set to 0
set mouse=a
" use mouse in xterm to scroll
set nocompatible
set nowrap
" display long lines as just one line
set number
set nomodeline
" ignore file's mode lines; use vimrc config instead  2022-09-22 thu 11:05 am
set noshowmode
" we don't need to see things like -- insert -- anymore
set nobackup
" this is recommended by coc
set nopaste
" set paste causes escape keybinding issues
set nowritebackup
" this is recommended by coc
set path+=**
"  searches subdirectories when using :find
set pumheight=10
" makes popup menu smaller
set rtp+=~/.fzf
set ruler
" show the cursor position all the time
set scrolloff=5
" 5 lines before and after the current line when scrolling
set shiftround
set shiftwidth=2
" change the number of space characters inserted for indentation
set showcmd
set showmatch
" showmatch: show the matching bracket for the last ')'?
set showmode
set showtabline=2
" always show tabs
set sidescrolloff=5
" number of screen columns to keep left and righ of cursor 2022-09-22 thu 10:49 am
set smartcase
set smarttab
" makes tabbing smarter will realize you have 2 vs 4
set smartindent
" makes indenting smart
set softtabstop=4
set splitbelow
" horizontal splits will automatically be below
set splitright
" vertical splits will automatically be to the right
set tabstop=2
" insert 2 spaces for a tab
set termguicolors
" to activate full color spectrum
set timeoutlen=500
" by default timeoutlen is 1000 ms
set title
" set window's title to file currently being edited
set t_co=256
" enable 256 color
" set cursorline guibg=lightblue ctermbg=lightgrey
set updatetime=300
" faster completion
set visualbell
" flash screen instead of beep error
set wildmenu
set wrap
" wrap long lines
" syntax enable
" enables syntax highlighing


"image viewing
"au bufread *.png,*.jpg,*.jpeg :call displayimage()
let g:netrw_browsex_viewer="xdg-open"

" word processing
autocmd bufreadpost *.docx :%!pandoc -f docx -t markdown " also try rst instead of markdown
autocmd bufreadpost *.odt :%!pandoc -f rst -t markdown

"remove whitespace
fun! Trimwhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! Trimwhitespace call Trimwhitespace() 
"converts: :call Trimwhitespace() to :Trimwhitespace





"vimwiki

" vimwiki and pandoc integration
augroup pandoc_syntax
   autocmd! filetype vimwiki set syntax=markdown.pandoc
augroup end
" au FileType vimwiki set filetype=vimwiki.markdown
" vimwiki interpretation
"autocmd filetype vimwiki setlocal syntax=markdown

set foldenable

let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#folding#mode = ["syntax"]
let g:pandoc#modules#enabled = ["formatting", "folding"]
let g:pandoc#formatting#mode = "h"

let g:vimwiki_folding='expr'
au FileType vimwiki set filetype=vimwiki.markdown

autocmd filetype vimwiki setlocal foldenable
" Folding
set foldenable
set foldminlines=1
"set foldlevelstart=10
" set foldmethod=expr
"set foldnestmax=10
set foldcolumn=2
" Defaults folds to open. Use zM to close
" au BufRead * normal zR
" This command was critical to folding in markdown
" let g:markdown_folding=1
" set foldlevel=99
highlight folded term=standout ctermfg=14
" No folding without this command

"let g:vimwiki_folding='custom'
let g:vimwiki_global_ext = 0
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_list = [{'path': '~/dropbox/vimwiki'}]
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

" for more help see :help statusline
set statusline=
set statusline+=%#diffadd#%{(mode()=='n')?'\ \ normal\ ':''}
set statusline+=%#diffchange#%{(mode()=='i')?'\ \ insert\ ':''}
set statusline+=%#diffdelete#%{(mode()=='r')?'\ \ rplace\ ':''}
set statusline+=%#cursor#%{(mode()=='v')?'\ \ visual\ ':''}
set statusline+=\ %n\           " buffer number
set statusline+=%#visual#       " colour
set statusline+=%{&paste?'\ paste\ ':''}
set statusline+=%{&spell?'\ spell\ ':''}
set statusline+=%#cursorim#     " colour
set statusline+=%r              " readonly flag
set statusline+=%m              " modified [+] flag
set statusline+=%#cursor#       " colour
set statusline+=%#cursorline#   " colour
set statusline+=\ %t\           " short file name
set statusline+=%=              " right align
set statusline+=%#cursorline#   " colour
set statusline+=\ %y\           " file type
set statusline+=%#cursorim#     " colour
set statusline+=\ %3l:%-2c\     " line + column
set statusline+=%#cursor#       " colour
set statusline+=\ %3p%%\        " percentage
hi user1 ctermbg=gray  ctermfg=black
hi user2 ctermbg=gray  ctermfg=red cterm=bold
color industry
if has('gui_running')
"  set guifont=consolas:h11
    set guifont="caskaydiacove nerd font":h12
endif

"  start nerdtree, unless a file or session is specified, eg. vim -s session_file.vim.
autocmd stdinreadpre * let s:std_in=1

" ----------------------------------------
"
" automatic installation of vim-plug, if it's not available
" ----------------------------------------
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -flo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
autocmd Vimenter * PlugInstall --sync | source $MYVIMRC
endif
"-----------------------------------------
"
""-----------------------------------------
" automatically install missing plugins on startup
"-----------------------------------------
autocmd Vimenter *
      \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
      \|   PlugInstall --sync | q
      \| endif
"-----------------------------------------
"-----------------------------------------
" plugins
"-----------------------------------------
silent! if plug#begin('~/.vim/plugged')
"plugins (using vim-plug)
" specify a directory for plugins
" requires git. if using portable, then add git.exe to path.
" require vim-plug (vim-plug needs to be in the autoload directory)
" - for neovim: stdpath('data') . '/plugged'
" - avoid using standard vim directory names like 'plugin'
"   :pluginstall <-- enter this to install, also must be admin!
" comment out plugin, source vimrc, then run :plugclean to uninstall

call plug#begin('~/.vim/plugged')
Plug 'https://github.com/bling/vim-airline'
Plug 'https://github.com/burntsushi/ripgrep' "install with apt
Plug 'https://github.com/junegunn/vim-peekaboo'
Plug 'https://github.com/renerocksai/calendar-vim'
Plug 'https://github.com/dense-analysis/ale'
Plug 'https://github.com/folke/which-key.nvim'
Plug 'https://github.com/glepnir/dashboard-nvim'
" Plug 'https://github.com/itchyny/calendar.vim'
Plug 'https://github.com/jiangmiao/auto-pairs'
Plug 'https://github.com/junegunn/goyo.vim'
Plug 'https://github.com/junegunn/fzf.vim'
Plug 'https://github.com/junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'https://github.com/mzlogin/vim-markdown-toc'
Plug 'https://github.com/matze/vim-move'
Plug 'https://github.com/mattn/emmet-vim'
"Plug 'https://github.com/iamcco/markdown-preview.nvim'
Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/nvim-telescope/telescope-media-files.nvim'
Plug 'https://github.com/nvim-telescope/telescope-fzy-native.nvim'
Plug 'https://github.com/nvim-telescope/telescope-symbols.nvim'
Plug 'https://github.com/nvim-telescope/telescope-media-files.nvim'
Plug 'https://github.com/nvim-telescope/telescope.nvim'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter'
Plug 'https://github.com/nvim-lua/plenary.nvim'
Plug 'https://github.com/nvim-lua/popup.nvim'
Plug 'https://github.com/preservim/tagbar'
Plug 'https://github.com/rafi/awesome-vim-colorschemes'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/scrooloose/nerdtree' ", { 'on':  'nerdtreetoggle' }
Plug 'https://github.com/sharkdp/fd' "install with apt
Plug 'https://github.com/tc50cal/vim-terminal'
Plug 'https://github.com/renerocksai/Telekasten.nvim'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/tpope/vim-sensible'
" Plug 'https://github.com/tpope/vim-surround'
" Plug 'https://github.com/jamshedvesuna/vim-markdown-preview'
Plug 'https://github.com/vim-pandoc/vim-pandoc'
Plug 'https://github.com/vim-pandoc/vim-pandoc-syntax'
" Plug 'https://github.com/tpope/vim-unimpaired' ~lots of conflicts with keybindings"
Plug 'madox2/vim-ai', { 'do': './install.sh' }

Plug 'https://github.com/vimwiki/vimwiki'
Plug 'https://github.com/walm/jshint.vim' "jshint
call plug#end()
endif
" vim-plug does not require any extra statement other than plug#begin()
" and plug#end(). you can remove filetype off, filetype plugin indent on
" and syntax on from your .vimrc as they are automatically handled by
" plug#begin() and plug#end()
"-----------------------------------------

let g:airline#extensions#wordcount#filetypes = '\vasciidoc|help|mail|markdown|markdown.pandoc|org|rst|tex|text'
let g:airline#extensions#tabline#enabled = 1

autocmd stdinreadpre * let s:std_in=1
" autocmd vimenter * if argc() == 0 && !exists("s:std_in") | nerdtree | endif
let g:dashboard_default_executive ='telescope'

lua require('telescope').load_extension('fzy_native')
let g:airline_powerline_fonts = 1 " for airline fonts

" Vim built-in term for task undo in gvim
let g:task_gui_term        = 1
let g:coc_global_extensions=[ 'coc-powershell' ]
let g:dashboard_default_executive ='telescope'

" Telekasten
nnoremap <leader>zf :lua require('Telekasten').find_notes()<cr>
nnoremap <leader>zd :lua require('Telekasten').find_daily_notes()<cr>
nnoremap <leader>zg :lua require('Telekasten').search_notes()<cr>
nnoremap <leader>zz :lua require('Telekasten').follow_link()<cr>
nnoremap <leader>zt :lua require('Telekasten').goto_today()<cr>
nnoremap <leader>zw :lua require('Telekasten').goto_thisweek()<cr>
nnoremap <leader>zw :lua require('Telekasten').find_weekly_notes()<cr>
nnoremap <leader>zn :lua require('Telekasten').new_note()<cr>
nnoremap <leader>zn :lua require('Telekasten').new_templated_note()<cr>
nnoremap <leader>zy :lua require('Telekasten').yank_notelink()<cr>
" nnoremap <leader>zc :lua require('Telekasten').show_calendar()<cr>
nnoremap <leader>zc :CalendarT<cr>
nnoremap <leader>zi :lua require('Telekasten').paste_img_and_link()<cr>
nnoremap <leader>zt :lua require('Telekasten').toggle_todo()<cr>
nnoremap <leader>zb :lua require('Telekasten').show_backlinks()<cr>
nnoremap <leader>zf :lua require('Telekasten').find_friends()<cr>
nnoremap <leader>zi :lua require('Telekasten').insert_img_link({ i=true })<cr>
nnoremap <leader>zp :lua require('Telekasten').preview_img()<cr>
nnoremap <leader>zm :lua require('Telekasten').browse_media()<cr>
nnoremap <leader>za :lua require('Telekasten').show_tags()<cr>
nnoremap <leader># :lua require('Telekasten').show_tags()<cr>
"nnoremap <silent> <leader>zk :call nextclosedfold('k')<cr>
nnoremap <silent> <leader>zj :<c-u>call repeatcmd('call nextclosedfold("j")')<cr>
nnoremap <silent> <leader>zk :<c-u>call repeatcmd('call nextclosedfold("k")')<cr>

" we could define [[ in **insert mode** to call insert link
" inoremap [[ <cmd>:lua require('Telekasten').insert_link()<cr>
" alternatively: leader [
inoremap <leader>[ <cmd>:lua require('Telekasten').insert_link({ i=true })<cr>
inoremap <leader>zt <cmd>:lua require('Telekasten').toggle_todo({ i=true })<cr>
inoremap <leader># <cmd>lua require('Telekasten').show_tags({i = true})<cr>

" Telekasten on hesitation, bring up the panel
nnoremap <leader>z :lua require('Telekasten').panel()<cr>

" functions:
" function for file extension '.pdf'
function! Nfh_pdf(f)
  execute '!zathura' a:f "$@"
endfunction


function! Test()
 $1=%:r ;
 echo $1;
endfunction



" function for jumping folds
"https://stackoverflow.com/questions/9403098/is-it-possible-to-jump-to-the-next-closed-fold-in-vim
"  map leader to allow jumping between folds
"nnoremap <silent> <leader>zj :call nextclosedfold('j')<cr>     " not sure why this is grayed out

function! Nextclosedfold(dir)
    let cmd = 'norm!z' . a:dir
    let view = winsaveview()
    let [l0, l, open] = [0, view.lnum, 1]
    while l != l0 && open
        exe cmd
        let [l0, l] = [l, line('.')]
        let open = foldclosed(l) < 0
    endwhile
    if open
        call winrestview(view)
    endif
endfunction

" adds repeatability to the above function
function! Repeatcmd(cmd) range abort
    let n = v:count < 1 ? 1 : v:count
    while n > 0
        exe a:cmd
        let n -= 1
    endwhile
endfunction

"
" lua << eof
"   require("which-key").setup {
"     -- your configuration comes here
"     -- or leave it empty to use the default settings
"     -- refer to the configuration section below
"   }
" eof

" ----- the following are for syntax-coloring [[links]] and ==highlighted text==
" ----- (see the section about coloring in readme.md)
" for gruvbox
" hi tklink ctermfg=72 guifg=#689d6a cterm=bold,underline gui=bold,underline
" hi tkbrackets ctermfg=gray guifg=gray

" real yellow
" hi tkhighlight ctermbg=yellow ctermfg=darkred cterm=bold guibg=yellow guifg=darkred gui=bold
" gruvbox
" hi tkhighlight ctermbg=214 ctermfg=124 cterm=bold guibg=#fabd2f guifg=#9d0006 gui=bold
" hi link calnavi calruler
" hi tktagsep ctermfg=gray guifg=gray
" hi tktag ctermfg=175 guifg=#d3869b
" topractice:
" :read
" zz: save and quit in normal mode
"
" todo:
" map ctrl-s for saving in normal mode

" toresearch:
" :help backup and writebackup


" whydisabled:
" tnoremap <esc> <c-\><c-n>
" maps leader and ' to put quotes around any word in normal mode
" :nnoremap <leader>' viw<esc>a"<esc>bi"<esc>lel
" map leader and ' to put quotes around any highlighted text in visual mode
" :vnoremap <leader>' c""<esc>p
" map leader and { to put brackets around any highlighted text
" :nnoremap <leader>[ ve<esc>a}<esc>hbi{<esc>lel

" set shell                               " the shell used to execute commands. all i'm noticing is the word shell at the bottom all of the time. not sure of use.

" autocomplete braces           " unhighlighted because need option for braces on same line sometimes
" inoremap { {<cr>}<esc>ko

" autocmd vimenter * dashboard

" autocmd stdinreadpre * let s:std_in=1

" nerdtree
" autocmd vimenter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | nerdtree | endif

" autocmd vimenter * if argc() == 0 && !exists('s:std_in') && v:this_session == '' | nerdtree | endif

" resize with arrows
" nnoremap "<c-up>" ":resize -2<cr>"
" nnoremap "<c-down>" ":resize +2<cr>"
" nnoremap "<c-left>" ":vertical resize -2<cr>"
" nnoremap "<c-right>" ":vertical resize +2<cr>"
" nnoremap <leader>mdo :markdownpreview<cr>
" nnoremap <leader>mdc :markdownpreviewclose<cr>
" let vim_markdown_preview_hotkey='<c-p>'
" let vim_markdown_preview_temp_file=1
"let vim_markdown_preview_pandoc=1
"let vim_markdown_preview_toggle=1
"let vim_markdown_preview_browser='brave'

" required for neoclip
"  use {
"   "acksld/nvim-neoclip.lua",
"   requires = {
"     -- you'll need at least one of these
"      {'nvim-telescope/telescope.nvim'},
"     -- {'ibhagwan/fzf-lua'},
"   }
"   config = function()
"     require('neoclip').setup()
"   end,
" }

" lua require('telescope').load_extension('neoclip')


" zo open current fold under the cursor.
" zc close current fold under the cursor.
" za toggle current fold under the cursor.
" zd delete fold under the cursor. (only the fold, text is unchanged.)
" zj move the cursor to the next fold.
" zk move the cursor to the previous fold.
" zr open all folds in a current buffer. (reduce all folds)
" zm close all open folds in a current buffer. (close more and more folds)
" ze delete all folds the current buffer
" :fold in visual mode: fold selected lines.

" ctrl -w r  rotate the window pane from left to right (only if they are split vertically)

"  ctrl -w r  rotate the window pane from right to left (only if they are split vertically)
" ctrl -w h  move current window pane to the far left and use the full height of the screen
" ctrl -w j  move current window pane to the far bottom and use the full width of the
" ctrl -w =  resize the window pane equally
" ctrl -w >  incrementally increase the window pane to the right (takes a parameter: ctrl-w 10 >)
" ctrl -w < incrementally increase the window pane to the left (or ctrl-w 10 <)
" ctrl -w - incrementally decrease the window pane’s height (or ctrl-w 5 -)
" ctrl -w + incrementally increase the window pane’s height (or ctrl-w 5 +)
" :only to show 1 window pane

"set statusline=     "reset statusline
"set statusline+=%1* "black on gray
"set statusline+=%f      "full filename
"set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
"set statusline+=%{&ff}] "file format
"set laststatus=2
"set statusline+=\ %y    "filetype
"set statusline+=\ %h    "help file flag
"set statusline+=\ %2*   "white on red
"set statusline+=%m      "modified flag
"set statusline+=%1* "black on gray
"set statusline+=\ %r    "read only flag
"set statusline+=%=      "left/right separator
"set statusline+=%c,     "cursor column
"set statusline+=%l/%l   "cursor line/total lines
"set statusline+=\ \ %p  "percent through file


" # initialize unite's global list of menus
" if !exists('g:unite_source_menu_menus')
"     let g:unite_source_menu_menus = {}
" endif
"
" # create an entry for our new menu of commands
" let g:unite_source_menu_menus.my_commands = {
"     'description': 'my commands'
"  }
"
" # define the function that maps our command labels to the commands they execute
" function! g:unite_source_menu_menus.my_commands.map(key, value)
"     return {
"        'word': a:key,
"        'kind': 'command',
"        'action__command': a:value
"      }
" endfunction
"
" # define our list of [label, command] pairs
" let g:unite_source_menu_menus.my_commands.command_candidates = [
"    ['open/close nerdtree', 'nerdtreetoggle'],
"    ['git blame', 'gblame'],
"    ['grep for todos', 'grep todo']
"  ]
"
" # create a mapping to open our menu
" nnoremap <leader>i :<c-u>unite menu:my_commands -start-insert -ignorecase<cr>
"
" lua << end
" local home = vim.fn.expand("~/zettelkasten")
" require('Telekasten').setup({
"     home         = home
"     dailies      = home .. '/' .. 'daily',
"     weeklies     = home .. '/' .. 'weekly',
"     templates    = home .. '/' .. 'templates',
"     extension    = ".md",
"
"     -- following a link to a non-existing note will create it
"     follow_creates_nonexisting = true,
"     dailies_create_nonexisting = true,
"     weeklies_create_nonexisting = true,
"
"     -- template for new notes (new_note, follow_link)
"     template_new_note = home .. '/' .. 'templates/new_note.md',
"
"     -- template for newly created daily notes (goto_today)
"     template_new_daily = home .. '/' .. 'templates/daily.md',
"
"     -- template for newly created weekly notes (goto_thisweek)
"     template_new_weekly= home .. '/' .. 'templates/weekly.md',
"
"     -- integrate with calendar-vim
"     plug_into_calendar = true,
"     calendar_opts = {
"         -- calendar week display mode: 1 .. 'wk01', 2 .. 'wk 1', 3 .. 'kw01', 4 .. 'kw 1', 5 .. '1'
"         weeknm = 4,
"         -- use monday as first day of week: 1 .. true, 0 .. false
"         calendar_monday = 1,
"         -- calendar mark: where to put mark for marked days: 'left', 'right', 'left-fit'
"         calendar_mark = 'left-fit',
"     }
" })
" end
"
" help section
" :help ex-cmd-index

" node and javacript development
" let g:ale_sign_error = '❌'
" let g:ale_sign_warning = '⚠️ '


