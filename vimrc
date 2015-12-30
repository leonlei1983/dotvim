" ======My own KEY=======
" \q   toggle auto indent
" <F4> list all calls function          //cscope
" <F8> Nerdtree toggle
" <F6> Tagbar toggle                    //exuberant-ctags
" <F11> gen cscope file & connect to it //cscope
" <F7> cscope jump to file              //cscope

" =======COMMAND=============
" :cs f f RegEx   (Find file)
" :cs f e RegEx   (Find any string that conatin RegEx)

" ======motion=======
" [[ : to function head
" { : to previous blank line
" g* : search word without \<\>

" ============vimdiff===============
" ]c        : next diff
" za        : toggle current fold
" zi        : toggle ALL fold

" ============Pathogen vim plugin managment==================
call pathogen#infect()
call pathogen#helptags()



" **************************************
" *****    VIM SETTING CONFIG      *****
" **************************************

syntax on
filetype plugin on
set ofu=syntaxcomplete#Complete
set wildignore=*.o,*.obj,*.exe,*.so,*.lo,*.a
set diffopt+=vertical
" set invlist

" set cursorcolumn
" set nocompatible

set t_Co=256
" colorscheme desert
colorscheme molokai

" force the vim open text file with Unix linebreak
set ff=unix

" ===performance enhence===
set lazyredraw

" ======file backup=======
set nobackup
set nowb
set noswapfile

" ======search========
set ignorecase
set smartcase
set incsearch
set hlsearch
" set nowrapscan

" =====disable all err bell=====
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" ====tab expand to space====
set expandtab
set smarttab
set tabstop=4
set shiftwidth=4

" ====display related=====
set showmatch
set wildmenu
set wrap
set nonu
set tabpagemax=50

set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set tw=100
" set autowrite
set modifiable
set winminheight=0

" =======status bar=====
set laststatus=2
set statusline=%4*%<\ %1*[%F]
" set statusline+=%4*\ %5*[%{&encoding}, " encoding
" set statusline+=%{&fileformat}]%m " file format
set statusline+=[%{FileSize()}]%m " file size
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<%2*%p%%%4*\>
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white

" calculate filesize in K
function! FileSize()
    let bytes = getfsize(expand("%:p"))
    if bytes <= 0
        return ""
    endif
    if bytes < 1024
        return bytes
    else
        return (bytes / 1024) . "k"
    endif
endfunction


" =============cursorline color setting=================
" set background=dark	" light or dark
set autoread
set cursorline
" cterm=none -> disable underline, ctermbg=233 -> dark grey
hi CursorLine cterm=none
" line number color scheme
highlight LineNr cterm=NONE ctermfg=darkgrey ctermbg=NONE

" menu color scheme
highlight Pmenu ctermbg=239 ctermfg=247
highlight PmenuSel ctermbg=239 ctermfg=123
highlight PmenuSbar ctermbg=darkblue
highlight PmenuThumb ctermfg=gray

" =====toggle auto indent(useful when pasting)======
set pastetoggle=<leader>q


" **************************************
" *****SELF-CONTAIN VIM KEY MAPPING*****
" **************************************

nmap <SPACE> :nohlsearch<cr>

if version >= 700
    " map  <C-x> :mak<cr>

    " vim tab manipulation
    map  <C-c> :tabnew<CR>
    map <C-h> :tabprev<CR>
    map <C-l> :tabnext<CR>
end

" disable arrow keys in normal/insert mode,
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
" inoremap <Up> <nop>
" inoremap <Down> <nop>
" inoremap <Left> <nop>
" inoremap <Right> <nop>

" disable backspace
" map <BS> <nop>
" map! <BS> <nop>

" disbale hjkl arrow movement
" noremap h <nop>
" noremap j <nop>
" noremap k <nop>
" noremap l <nop>

" ========map the %% in Ex to current editing file's path ===========
cnoremap <expr> %% getcmdtype( ) == ':' ?expand('%:h').'/' : '%%'

" ctrl+j / ctrl+k can move the edit screen up/down
function! s:Saving_scroll(cmd)
  let save_scroll = &scroll
  execute 'normal! ' . a:cmd
  let &scroll = save_scroll
endfunction
nnoremap <C-J> :call <SID>Saving_scroll("1<C-V><C-D>")<CR>
vnoremap <C-J> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-D>")<CR>
nnoremap <C-K> :call <SID>Saving_scroll("1<C-V><C-U>")<CR>
vnoremap <C-K> <Esc>:call <SID>Saving_scroll("gv1<C-V><C-U>")<CR>

" Quickfix window toggle
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        botright copen 7
        set nornu
        set nu
        let g:qfix_win = bufnr("$")
    endif
endfunction
nmap <F3> :QFix<CR>


" *****************************************************
" ***** VIM PLUGIN & EXTERNAL EXE SETTING/MAPPING *****
" *****************************************************

" ===============Nerdtree toggle==============
nmap <F8> :NERDTreeToggle<CR>

" ================Tagbar toggle==================
nmap <F6> :TagbarToggle<CR>

" ================== cscope setting =====================
" Press F12 to generate/update tags file after modify source code
" You must situiate in project root folder to execute it
" (jump back & foward in the source code need this)
" You have to 'sudo apt-get install ctags  (exuberant-ctags)' first
" nmap <F12> :!ctags-exuberant -R --sort=yes --c++-kinds=+p --fields=iaS --extra=+q .<CR>

" Press F11 to generate/update cscope file after modifying source code
" You must situiate in project root folder to execute it
" (all the cscope action need this)
" You have to 'sudo apt-get install cscope' first
nmap <F11> :!find . -iname '*.[ch]' > cscope.files ; cscope -b -q<CR>:cs kill -1<CR>:cs add cscope.out<CR>

" display all calls function
nmap <F4> :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <F5> 9[{?(<cr>b:nohls<cr>:cs find c <C-R>=expand("<cword>")<CR><CR>

" jump to the header file
nmap <F7> :cs find f <C-R>=expand("<cfile>")<CR><CR>

" display all called function
" nmap <F3> :cs find d <C-R>=expand("<cword>")<CR><CR>

map <F2> :execute "grep! -rsIw --color=auto --include=*.{c,h} . -e " . expand("<cword>") . " " <bar> call QFixToggle(1)<CR><CR>
