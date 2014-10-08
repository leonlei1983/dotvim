" install vim plugin with git & bundle(pathogen)
" cd ~/.vim/bundle
" git clone git://github.com/tpope/vim-sensible.git
" note to remove the .git* related file then push to chin33z/dotvim

" ======My own KEY=======
" \q   toggle auto indent
" <F4> list all calls function          //cscope
" <F8> Nerdtree toggle
" <F6> Tagbar toggle                    //exuberant-ctags
" <F11> gen cscope file & connect to it //cscope
" <F7> cscope jump to file              //cscope
" <.....> filter g/re/ result to windows
" <c-p> CtrlP search for file/buffer/mru name
" <c-b> CtrlP search for buffer name

" =======COMMAND=============
" :cs f f RegEx   (Find file)
" :cs f e RegEx   (Find any string that conatin RegEx)

" ======global replacement======
"/search_term
":%s//replace_term/g

" ======motion=======
" [[ : to function head
" { : to previous blank line
" g* : search partial word

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


"============Pathogen vim plugin managment==================
call pathogen#infect()

syntax on
filetype plugin on
set ofu=syntaxcomplete#Complete
set wildignore=*.o,*.obj,*.exe
set diffopt+=vertical
"set invlist

"set cursorcolumn
"set nocompatible

set t_Co=256
"colorscheme desert
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
"set nowrapscan

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
set nowrap
set nonu
"set rnu

set bs=2		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
set tw=100
set autowrite
set modifiable
set winminheight=0
"set statusline+=%F
"set laststatus=2

" =======status bar=====
set laststatus=2
set statusline=%4*%<\ %1*[%F]
"set statusline+=%4*\ %5*[%{&encoding}, " encoding
"set statusline+=%{&fileformat}]%m " file format
set statusline+=[%{FileSize()}]%m " file size
set statusline+=%4*%=\ %6*%y%4*\ %3*%l%4*,\ %3*%c%4*\ \<\ %2*%p%%%4*\ \>
highlight User1 ctermfg=red
highlight User2 term=underline cterm=underline ctermfg=green
highlight User3 term=underline cterm=underline ctermfg=yellow
highlight User4 term=underline cterm=underline ctermfg=white
highlight User5 ctermfg=cyan
highlight User6 ctermfg=white


nmap <SPACE> :nohlsearch<cr>

" =====toggle auto indent(useful when pasting)======
set pastetoggle=<leader>q

" =======Filter in vim=========
" after searching for a text, type <F8> to redirect all lines containing the pattern to a file
"nnoremap <silent> <F8> :redir @a<CR>:g//<CR>:redir END<CR>:vnew<CR>:put! a<CR>

" ========grep in vim========
" search scope limited in the working directory

"For Linux kenrel
map <F2> :execute "grep! -rsIw --color=auto --include=*.{c,h} . -e " . expand("<cword>") . " " <bar> botright cw 7<CR><CR>

"For IBM AMM
"map <F2> :execute "grep! -rsIw --color=auto --include=*.{c,h,inc,php,pre} . -e " . expand("<cword>") . " " <bar> botright cw 7<CR><CR>


"set background=dark	" light or dark
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

if version >= 700
"ctrl+x (run)
  map  <C-x> :mak<cr>
  map  <C-c> :tabnew<CR> 

"ctrl+h(left)
  map <C-h> :tabprev<CR>
"ctrl+l(right)
  map <C-l> :tabnext<CR>
end



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


" map %% to the current working directory
cabbr <expr> %% expand('%:p:h')

" Quickfix window toggle
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        botright copen 7
        let g:qfix_win = bufnr("$")
        endif
endfunction
"nnoremap <leader>q :QFix<CR>
nmap <F3> :QFix<CR>

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


"===============Nerdtree toggle==============
nmap <F8> :NERDTreeToggle<CR>

"================Tagbar toggle==================
nmap <F6> :TagbarToggle<CR>

" Press F12 to generate/update tags file after modify source code
" You must situiate in project root folder to execute it
" (jump back & foward in the source code need this)
" You have to 'sudo apt-get install ctags  (exuberant-ctags)' first
"nmap <F12> :!ctags-exuberant -R --sort=yes --c++-kinds=+p --fields=iaS --extra=+q .<CR>

" Press F11 to generate/update cscope file after modifying source code
" You must situiate in project root folder to execute it
" (all the cscope action need this)
" You have to 'sudo apt-get install cscope' first
nmap <F11> :!find . -iname *.[CH] -o -iname *.cpp -o -iname *.hpp > cscope.files ; cscope -b -q<CR>:cs kill -1<CR>:cs add cscope.out<CR>

"display all calls function
nmap <F4> :cs find c <C-R>=expand("<cword>")<CR><CR>
nnoremap <F5> 9[{b%b:cs find c <C-R>=expand("<cword>")<CR><CR>

"jump to the header file
nmap <F7> :cs find f <C-R>=expand("<cfile>")<CR><CR>

"display all called function
"nmap <F3> :cs find d <C-R>=expand("<cword>")<CR><CR>

" make the <c-p> CtrlP use the current directory as source root
let g:ctrlp_working_path_mode = ''
map <C-b> :CtrlPBuffer<cr>

