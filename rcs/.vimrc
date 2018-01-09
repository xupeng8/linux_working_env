" For vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/  
call vundle#rc()  

" let Vundle manage Vundle  
Bundle 'gmarik/vundle'  

" vim-scripts repos
Bundle 'bash-support.vim'
Bundle 'perl-support.vim'
Bundle 'The-NERD-tree'
Bundle 'Tagbar'
Bundle 'SrcExpl'
Bundle 'indentpython.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'davidhalter/jedi-vim'
Plugin 'nvie/vim-flake8'
Plugin 'Vimjas/vim-python-pep8-indent'
Plugin 'tell-k/vim-autopep8'

filetype plugin indent on

" colorscheme
colo desert

" Backspace deletes like most programs in insert mode
set backspace=2
" Show the cursor position all the time
set ruler
" Display incomplete commands
set showcmd
" Set fileencodings
set fileencodings=utf-8,bg18030,gbk,big5
" ignore case in search patterns
set ic
" searches don't wrap around the end of the file
set nowrapscan
" display cursorline
set cursorline

" Softtabs, 2 spaces
set tabstop=4
set shiftwidth=4
set shiftround
"set expandtab

" Display extra whitespace
"set list listchars=tab:»·,trail:·

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Numbers
set number
set numberwidth=5

set matchpairs+=<:>
set hlsearch

" NERD tree
let NERDChristmasTree=0
let NERDTreeWinSize=35
let NERDTreeChDirMode=2
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
let NERDTreeShowBookmarks=1
let NERDTreeWinPos="left"
" Automatically open a NERDTree if no files where specified
autocmd vimenter * if !argc() | NERDTree | endif
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" Open a NERDTree
nmap nt :NERDTreeToggle<cr>

" Tagbar
let g:tagbar_width=35
let g:tagbar_autofocus=1
autocmd FileType c,cpp nested :TagbarOpen
nmap tb :TagbarToggle<CR>
nmap wm :TagbarToggle<CR>: set nonumber<CR>

" Source Explorer 
"autocmd FileType c,cpp nested :SrcExpl
nmap tse :SrcExplToggle<CR>  
" Set the height of Source Explorer window 
let g:SrcExpl_winHeight = 8 
" Set 100 ms for refreshing the Source Explorer 
let g:SrcExpl_refreshTime = 100 
" Set "Enter" key to jump into the exact definition context 
let g:SrcExpl_jumpKey = "<ENTER>" 
" Set "Space" key for back from the definition context 
let g:SrcExpl_gobackKey = "<SPACE>" 
" In order to Avoid conflicts, the Source Explorer should know what plugins 
" are using buffers. And you need add their bufname into the list below 
" according to the command ":buffers!" 
let g:SrcExpl_pluginList = [ 
            \ "__Tagbar__", 
            \ "NERD_tree_1", 
            \ "Source_Explorer" 
            \ ] 

" YouCompleteMe
" let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'  
" nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>  
" let g:ycm_python_binary_path = '/usr/bin/python3'  
" nmap<C-a> :YcmCompleter FixIt<CR>


let g:pymode_python = 'python3'
autocmd VimEnter *.py python3 sys.path.append('.')
autocmd BufWritePost *.py call Flake8()

"using flake8 as a python syntax checker 
let g:syntastic_python_checkers=['flake8']
let g:syntastic_python_flake8_args='--ignore=E501,E225'

" autopep8
let g:autopep8_aggressive=2

" jedi
let g:jedi#force_py_version=3
let g:jedi#smart_auto_mappings = 0

" settings of cscope.
" I use GNU global instead cscope because global is faster.
set cscopetag
set cscopeprg=gtags-cscope
set cscopequickfix=c-,d-,e-,f-,g0,i-,s-,t-

nmap <silent> <leader>j <ESC>:cstag <c-r><c-w><CR>
nmap <silent> <leader>g <ESC>:lcs f c <c-r><c-w><cr>:lw<cr>
nmap <silent> <leader>s <ESC>:lcs f s <c-r><c-w><cr>:lw<cr>
command! -nargs=+ -complete=dir FindFiles :call FindFiles(<f-args>)
au VimEnter * call VimEnterCallback()
au BufAdd *.[ch] call FindGtags(expand('<afile>'))
au BufWritePost *.[ch] call UpdateGtags(expand('<afile>'))

function! FindFiles(pat, ...)
    let path = ''
    for str in a:000
        let path .= str . ','
    endfor

    if path == ''
        let path = &path
    endif

    echo 'finding...'
    redraw
    call append(line('$'), split(globpath(path, a:pat), '\n'))
    echo 'finding...done!'
    redraw
endfunc

function! VimEnterCallback()
    for f in argv()
        if fnamemodify(f, ':e') != 'c' && fnamemodify(f, ':e') != 'h'
            continue
        endif

        call FindGtags(f)
    endfor
endfunc

function! FindGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    while 1
        let tmp = dir .  '/GTAGS'
        if filereadable(tmp)
            exe 'cs add ' .  tmp .  ' ' .  dir
            break
        elseif dir == '/'
            break
        endif

        let dir = fnamemodify(dir, ":h")
    endwhile
endfunc

function! UpdateGtags(f)
    let dir = fnamemodify(a:f, ':p:h')
    exe 'silent !cd ' .  dir .  ' && global -u &> /dev/null &'
endfunction
