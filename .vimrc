" Todo: 
"
" fuzzy headers for makeshift TOC
" quickfix headers :vimgrep /^#/ %
" Have quickfix automatically populate?

" runtime! Plugins/*.vim
for f in glob('~/.config/nvim/Plugins/*.*', 0, 1)
    execute 'source' f
endfor

" Searching
if executable('ag')
    set grepprg=ag\ --nogroup\ --nocolor\ --hidden\ --ignore\ .git
endif

" auto source when writing to init.vim alternatively you can run :source $myvimrc
au! bufwritepost $myvimrc source %

"image viewing
"au bufread *.png,*.jpg,*.jpeg :call displayimage()
let g:netrw_browsex_viewer="xdg-open"
let g:vimwiki_list = [{'path': '~/vimwiki', 'index': '100_Index'}]
" word processing
autocmd bufreadpost *.docx :%!pandoc -f docx -t markdown " also try rst instead of markdown
autocmd bufreadpost *.odt :%!pandoc -f rst -t markdown

" vimwiki and pandoc integration
augroup pandoc_syntax
   autocmd! filetype vimwiki set syntax=markdown.pandoc
 augroup end

let g:pandoc#filetypes#handled = ["pandoc", "markdown"]
let g:pandoc#filetypes#pandoc_markdown = 0
let g:pandoc#formatting#mode = "h"

" let g:vimwiki_folding='expr'
au FileType vimwiki set filetype=vimwiki.markdown

autocmd filetype vimwiki setlocal foldenable

"let g:vimwiki_folding='custom'
let g:vimwiki_global_ext = 0
let g:vimwiki_listsyms = '✗○◐●✓'
let g:vimwiki_list = [{'path': '~/dropbox/vimwiki'}]
let g:vimwiki_list = [{'path': '~/vimwiki/', 'syntax': 'markdown', 'ext': '.md'}]

if has('gui_running')
"  set guifont=consolas:h11
    set guifont="caskaydiacove nerd font":h12
endif

let NERDTreeHijackNetrw=1
" http://vimcasts.org/blog/2013/01/oil-and-vinegar-split-windows-and-project-drawer/
"  start nerdtree, unless a file or session is specified, eg. vim -s session_file.vim.
autocmd stdinreadpre * let s:std_in=1

"-----------------------------------------
"
"Javascript
"
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

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


lua require("noice").setup()
lua require("toggleterm").setup()
