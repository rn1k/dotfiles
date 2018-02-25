" dein settings {{{
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif
execute 'set runtimepath^=' . s:dein_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let g:rc_dir    = expand("~/.config/nvim/")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" 非同期処理のプラグインだけ入れておく
" if dein#check_install(['vimproc'])
"   call dein#install(['vimproc'])
" endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif
" }}}

"#
"# 一般的な設定
"#

"## 見た目
syntax enable
set number
set cursorline
set virtualedit=onemore
set showmatch
set laststatus=2
set wildmode=list:longest
set tabstop=4
set shiftwidth=4
set smarttab
set smartindent
set pastetoggle=<Leader>p

nnoremap j gj
nnoremap k gk
nnoremap ; :
nnoremap <C-j> <esc>
noremap! <C-j> <esc>
tnoremap <silent> <esc> <C-\><C-n>
tnoremap <silent> <C-j> <C-\><C-n>
" Esc2回で検索のハイライトを消す
nnoremap <silent> <Esc><Esc> :<C-u>nohlsearch<CR>

" split系 mapping {{{
nnoremap s <Nop>
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap sh <C-w>h
nnoremap sJ <C-w>J
nnoremap sK <C-w>K
nnoremap sL <C-w>L
nnoremap sH <C-w>H
nnoremap sn gt
nnoremap sp gT
nnoremap sr <C-w>r
nnoremap s= <C-w>=
nnoremap sw <C-w>w
nnoremap so <C-w>_<C-w>|
nnoremap sO <C-w>=
nnoremap ss :<C-u>sp<CR>
nnoremap sv :<C-u>vs<CR>
nnoremap st :<C-u>tabnew<CR>
nnoremap sN :<C-u>bn<CR>
nnoremap sP :<C-u>bp<CR>
nnoremap sq :<C-u>q<CR>
nnoremap sQ :<C-u>bd<CR>
" }}}

"## 検索系
set ignorecase
set smartcase
set wrapscan
set hlsearch

" vim:set foldmethod=marker:
