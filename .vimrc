" 一旦filetypeの検出をオフ
filetype off

" *** 一般設定 ***
" ステータスラインを末尾2行目に表示
set laststatus=2
" 256色表示
set t_Co=256
" 行番号表示(set numberと同じ)
set nu
" 画面上でタブ文字が占める幅
set tabstop=2
" 自動インデント幅
set shiftwidth=2
" タブ入力をスペースに分解
set expandtab
" タブキーで入力される文字幅(0ならtabstopと同じ値)
set softtabstop=0
" 改行時にインデントを継承
set autoindent
" 改行時にインデントを増減
set smartindent
" 背景色
set background=light
" マウスモード(全てのモードに適用)
set mouse=a
" シンタックスハイライト
syntax on
" クリップボードへのコピー
set clipboard+=unnamed
" バックスペース有効
set backspace=indent,eol,start
" *** 一般設定ここまで ***


" ******************* NeoBundle関連 ***********************
if has('vim_starting') " vim最初の起動時のみパス追加
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif
" NeoBundleの初期化と読み込み開始
call neobundle#begin(expand('~/.vim/bundle/'))

" statuslineを見やすい色にする(https://github.com/itchyny/lightline.vim)
NeoBundle 'itchyny/lightline.vim'
" vim上でrunできる
NeoBundle 'thinca/vim-quickrun'
" カラーコードを色付け
NeoBundle 'lilydjwg/colorizer'

" ***ハイライト関連***
" Processing
NeoBundle 'sophacles/vim-processing'
" GO言語
NeoBundle 'fatih/vim-go'
" ***ハイライト関連***

" コメントアウト効率化
NeoBundle 'tomtom/tcomment_vim'
" インデントの可視化
NeoBundle 'nathanaelkane/vim-indent-guides'
" ファイルをtree表示
NeoBundle 'scrooloose/nerdtree'

" 読み込み終わり
call neobundle#end()
filetype plugin indent on
NeoBundleCheck
" ******************* NeoBundle関連ここまで ***********************


" ******************* vim-indent-guides関連 ***********************
" 起動
let g:indent_guides_enable_on_vim_startup = 1
" 色の変更、奇数行の色、偶数行の色
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * hi IndentGuidesOdd  guibg=#303030 ctermbg=236
autocmd VimEnter,Colorscheme * hi IndentGuidesEven guibg=#4e4e4e ctermbg=239
" 背景色
autocmd ColorScheme * hi Normal ctermbg=000
autocmd ColorScheme * hi Visual ctermbg=90
" カラースキームをmolokaiに(.vim/colors/molokai.vim)
colorscheme molokai
let g:molokai_original = 1


" ****************** quickrun関連 *******************
let g:quickrun_config = get(g:, 'quickrun_config', {})

" Processing
let g:quickrun_config.processing =  {
      \     'command': 'processing-java',
      \     'exec': '%c --sketch=$PWD/ --output=/Library/Processing --run --force',
      \   }
" ****************** quickrun関連ここまで *******************

" *** 前回セッション終了時のカーソル位置を復元 ***
function! s:RestoreCursorPostion()
	  if line("'\"") <= line("$")
		      normal! g`"
		          return 1
	  endif
endfunction
augroup vimrc_restore_cursor_position
  autocmd!
  autocmd BufWinEnter * call s:RestoreCursorPostion()
augroup END
" *** カーソル位置復元ここまで ***

" pdeを読み込むとArduinoと認識されてしまうので
augroup Processing
	    autocmd!
	    autocmd BufNewFile,BufRead *.pde NeoBundleSource vim-processing
augroup END
" pde読み込み関連ここまで

" 改行時にコメントを無効化
autocmd FileType * set formatoptions-=ro
