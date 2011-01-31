syntax on

highlight ZenkakuSpace ctermbg=6
match ZenkakuSpace /　/

highlight Pmenu ctermbg=6 guibg=#4c745a
highlight PmenuSel ctermbg=3 guibg=#d4b979
highlight PmenuSbar ctermbg=0 guibg=#333333

if &term =~ "xterm-256color"
	colorscheme wombat
	highlight Pmenu ctermbg=8
	highlight PmenuSel ctermbg=12
	highlight PmenuSbar ctermbg=0
endif

if has('gui_macvim')
	colorscheme wombat
	set antialias
	set guifont=Menlo:h13
	set guioptions-=T
	set lines=90 columns=200
	set showtabline=2
	set termencoding=japan
	set transparency=30
endif

set ambiwidth=double
set autoindent smartindent
set autoread
set backspace=indent,eol,start
set clipboard=unnamed
set complete=.,w,b,u,k
set completeopt=menu,preview,longest,menuone
set encoding=utf-8
set fileencodings=euc-jp,iso-2022-jp
set hidden
set ignorecase smartcase
set iminsert=0 imsearch=0
set incsearch
set laststatus=2
set lazyredraw
set list
set listchars=tab:>.
set listchars+=precedes:<,extends:>
set nobackup
set nofoldenable
set nowrap
set nowrapscan
set nrformats=hex,alpha
set number
set scrolloff=10000000
set showcmd
set showmatch
set sidescroll=5
set smarttab
set softtabstop=4 tabstop=4 shiftwidth=4
set splitbelow
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']['.&ft.']'}\ U+%4B\ %=%l,%c%V%8P
set viminfo+=!
set whichwrap=b,s,h,l,<,>,[,]
set wildmenu
set wildmode=longest,list

let termencoding=&encoding

function! CharacterCount()
	redir @c
	silent exe "normal g\<C-g>"
	redir END
	return matchstr(@c, '[0-9]* of [0-9]* Chars')
endfunction

filetype indent on
filetype plugin on

autocmd BufNewFile,BufRead *.cgi set filetype=perl
autocmd BufNewFile,BufRead *.io set filetype=io
autocmd BufNewFile,BufRead *.scala set filetype=scala
autocmd BufNewFile,BufRead COMMIT_EDITMSG set filetype=git fenc=utf-8 | AutoComplPopDisable

" mapping
nnoremap j gj
nnoremap k gk
nnoremap <C-c>  :<C-u>close<CR>
nnoremap <C-d>  :<C-u>buffer # \| bwipe #<CR>
nmap <silent> eo :e %:h<CR>

" encoding
nmap <silent> eu :set fenc=utf-8<CR>
nmap <silent> ee :set fenc=euc-jp<CR>
nmap <silent> es :set fenc=cp932<CR>

" encode reopen encoding
nmap <silent> eru :e ++enc=utf-8 %<CR>
nmap <silent> ere :e ++enc=euc-jp %<CR>
nmap <silent> ers :e ++enc=cp932 %<CR>
nmap <silent> err :e %<CR>

" indent whole buffer
noremap <F8> gg=G``

" insert timestamp
nmap <F9> :exe "normal! i" . strftime("%Y-%m-%d\T%H:%M:%S+09:00")<CR>

" redraw map
nmap <silent> sr :redraw!<CR>

" sort css property (id:secondlife)
nmap gso vi{:!sortcss<CR>
vmap gso i{:!sortcss<CR>

" cmode
cmap <ESC>h <Left>
cmap <ESC>l <Right>

" good_width
nnoremap <C-w><C-w> <C-w><C-w>:call <SID>good_width()<CR>
nnoremap <C-w>h <C-w>h:call <SID>good_width()<CR>
nnoremap <C-w>j <C-w>j:call <SID>good_width()<CR>
nnoremap <C-w>k <C-w>k:call <SID>good_width()<CR>
nnoremap <C-w>l <C-w>l:call <SID>good_width()<CR>

function! s:good_width()
	if winwidth(0) < 100
		vertical resize 100
	endif
endfunction

" augroup
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre  *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END

augroup Indent
	au!
	au BufNewFile,BufRead *yuno/* set expandtab softtabstop=4 tabstop=4 shiftwidth=4
augroup END

augroup MyAutocmd
	au!
	autocmd BufWritePost * if getline(1) =~ "^#!" | exe "silent !chmod +x %" | endif
	autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "k%\\"' | endif

	" YAML setting
	autocmd FileType yaml setlocal expandtab ts=2 sw=2 enc=utf-8 fenc=utf-8
	autocmd BufEnter * set nowrap


	" auto cd
	" autocmd BufEnter * exe ":lcd \"" . expand("%:p:h") . "\""

	" use 'encoding' if the buffer doesn't contain any multibyte character.
	autocmd BufReadPost *
				\   if &modifiable && !search('[^\x00-\x7F]', 'cnw')
				\ |   setlocal fileencoding=
				\ | endif
augroup END

augroup MyXML
	autocmd!
	autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
	autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
augroup END

" autocomplepop
let g:AutoComplPop_CompleteOption = '.,w,b,k'
let g:AutoComplPop_Behavior = {
			\   'java' : [
			\     {
			\       'command'  : "\<C-n>",
			\       'pattern'  : '\k\k$',
			\       'excluded' : '^$',
			\       'repeat'   : 0,
			\     },
			\     {
			\       'command'  : "\<C-x>\<C-u>",
			\       'pattern'  : '\k\k$',
			\       'excluded' : '^$',
			\       'repeat'   : 0,
			\     },
			\     {
			\       'command'  : "\<C-x>\<C-f>",
			\       'pattern'  : (has('win32') || has('win64') ? '\f[/\\]\f*$' : '\f[/]\f*$'),
			\       'excluded' : '[*/\\][/\\]\f*$\|[^[:print:]]\f*$',
			\       'repeat'   : 1,
			\     }
			\   ]
			\ }

" {{{ Autocompletion using the TAB key
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
function! InsertTabWrapper()
	let col = col('.') - 1
	if !col || getline('.')[col - 1] !~ '\k'
		return "\<TAB>"
	else
		if pumvisible()
			return "\<C-N>"
		else
			return "\<C-N>\<C-P>"
		end
	endif
endfunction
" Remap the tab key to select action with InsertTabWrapper
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" }}} Autocompletion using the TAB key

" fuf
let g:fuf_modesDisable = ['mrucmd']
let g:fuf_file_exclude = '\v\~$|\.(o|exe|bak|swp|gif|jpg|png)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])'
let g:fuf_mrufile_exclude = '\v\~$|\.bak$|\.swp|\.howm$|\.(gif|jpg|png)$'
let g:fuf_mrufile_maxItem = 500
let g:fuf_enumeratingLimit = 20
let g:fuf_keyPreview = '<C-]>'
let g:fuf_previewHeight = 0

nmap ff :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>
nmap fr :MRU<CR>
nmap fl :FufLine<CR>

" minibufexpl
:let g:miniBufExplMapWindowNavVim = 1
:let g:miniBufExplMapWindowNavArrows = 1
:let g:miniBufExplMapCTabSwitchBuffs = 1

" pathogen
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
