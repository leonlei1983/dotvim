" install vim plugin with git & bundle(pathogen)
" cd ~/.vim/bundle
" git clone git://github.com/tpope/vim-sensible.git
" note to remove the .git* related file then push to chin33z/dotvim

" =====project specific setting========
" :call ProjMake()   //tracing make file
" :call ProjKernel()   //tracing Linux kernel source

" ======My own KEY=======
" \q   toggle auto indent
" <F4> list all calls function          //cscope
" <F8> Nerdtree toggle
" <F6> Tagbar toggle                    //exuberant-ctags
" <F11> gen cscope file & connect to it //cscope
" <F7> cscope jump to file              //cscope
" <F9> filter search result to windows
" <c-p> CtrlP search for file/buffer/mru name
" <c-b> CtrlP search for buffer name
" Use F2 to grep all the hits, then :Qdo %s/old_str/new_str/gc | update

" =======COMMAND=============
" :cs f f RegEx   (Find file)
" :cs f e RegEx   (Find any string that conatin RegEx)

" ======global replacement======
" /search_term
" :%s//replace_term/g

" ======motion=======
" [[ : to function head
" { : to previous blank line
" g* : search word without \<\>

" =====normal mode=========
" yiW : word sepereate by space(yank abc->df)  [act]i[block]
" vit : copy inner tag <a>XXXXXX</a>
" 2daw : delete two words
" gg=G indent the current file   [act]to[pos]
" A : jump to line tail and insert

" ==========insert mode==========
" ^u : backspace a line
" ^w : backspace a word
" ^h : backspace a letter
" ^t / ^d : indent current line in insert mode

" ============vimdiff===============
" ]c        : next diff
" za        : toggle current fold
" zi        : toggle ALL fold

" ==========vim macro=============
" qqXXXXXXq : put all the action/motion in reg q
" @q        : run the reg q
" @@        : repeat the last macro I ran
" 5@q       : repeat 5 times of reg q

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
set rnu  " rnu can be used like nu ===>  :-8,-3m9
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
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%p%%%4*\ \>
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

" =======Filter in vim=========
" after searching for a text, type <F9> to redirect all lines containing the pattern to a file
nnoremap <silent> <F9> :redir @a<CR>:g//<CR>:redir END<CR>:tabe<CR>:put! a<CR>


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


" function to copy the matched strings to a file
" Useage
" after matching, ":CopyMatches k" to save all the match hits to register k
" then "kp to paste the content
function! CopyMatches(reg)
  let hits = []
  %s//\=len(add(hits, submatch(0))) ? submatch(0) : ''/ge
  let reg = empty(a:reg) ? '+' : a:reg
  execute 'let @'.reg.' = join(hits, "\n") . "\n"'
endfunction
command! -register CopyMatches call CopyMatches(<q-reg>)



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

"============replace the CtrlP with Command-T if exist===============
autocmd VimEnter * :call CommandT_Replacement()
function! CommandT_Replacement()
    if exists(":CommandT")
        nnoremap <c-p> :CommandT<CR>
        nnoremap <c-b> :CommandTBuffer<CR>

        let g:CommandTTraverseSCM = 'pwd'
        let g:CommandTAlwaysShowDotFiles = 1
        let g:CommandTMatchWindowReverse = 1

        let g:CommandTMaxFiles = 500000
        let g:CommandTMaxHeight = 10
        let g:CommandTMaxCachedDirectories = 10

        " if executable('watchman')
        "     let g:CommandTFileScanner = 'watchman'
        " endif

        let g:CommandTCursorLeftMap = ['<nop>']
        let g:CommandTBackspaceMap = ['<C-h>']
        let g:CommandTCancelMap = ['<C-c>', '<Esc>']
    endif
endfunction

" =======The Silver Searcher==========
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor\ --column
  set grepformat=%f:%l:%c:%m

  " Use ag to grep --cc
  map <F2> :grep! -sw --cc <C-R><C-W><CR> <bar> :call QFixToggle(1)<CR>

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --hidden -g *'

else
     " For Linux kernel
    map <F2> :execute "grep! -rsIw --color=auto --include=*.{c,h} . -e " . expand("<cword>") . " " <bar> call QFixToggle(1)<CR><CR>
endif


" ============= CtrlP setting =================
let g:ctrlp_working_path_mode = ''
map <C-b> :CtrlPBuffer<cr>

"========= project specific setting========
function! ProjMake()
    map <F4> <nop>
    map <F5> <nop>
    map <F6> <nop>
    map <F7> <nop>
    map <F11> <nop>
    if executable('ag')
        map <F2> :grep! -sw -G Make <C-R><C-W><CR> <bar> :call QFixToggle(1)<CR>
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g Make'
        nmap <F12> :!ag -l --nocolor -g Make > ctags.files.list && ctags -L ctags.files.list --language-force=Make --regex-make="/^([A-Z_]+):/\1/"<CR>
    else
        map <F2> :execute "grep! -rsIw --color=auto --include=*[mM][aA][kK][eE]* . -e " . expand("<cword>") . " " <bar> call QFixToggle(1)<CR><CR>
        let g:ctrlp_user_command = 'find %s -iname "*make*"'
        nmap <F12> :!find . -iname 'make*' > ctags.files.list && ctags -L ctags.files.list --language-force=Make --regex-make="/^([A-Z_]+):/\1/"<CR>
    endif
endfunction

function! ProjKernel()
    map <F11> :!make cscope; cscope -b -q<CR>:cs kill -1<CR>:cs add cscope.out<CR>
endfunction
