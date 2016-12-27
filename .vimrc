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
set hlsearch
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
" ***** vim-indent-guides関連ここまで *****


" *********** neocomplete関連 **********
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4
" 補完ウィンドウの設定
set completeopt=menuone
" 補完ウィンドウの設定
set completeopt=menuone
" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'
" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1
" 起動時に有効化
let g:neocomplete#enable_at_startup = 1
" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#enable_smart_case = 1
" _(アンダースコア)区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#enable_camel_case_completion  =  1
" 最初の補完候補を選択状態にする
let g:neocomplete#enable_auto_select = 1
" ポップアップメニューで表示される候補の数
let g:neocomplete#max_list = 20
" シンタックスをキャッシュするときの最小文字長
let g:neocomplete#min_syntax_length = 3
" 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif
  let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
  if !exists('g:neocomplete#keyword_patterns')
            let g:neocomplete#keyword_patterns = {}
          endif
          let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" ***** neocomplete関連ここまで *****


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

" ペーストモード自動化
if &term =~ "xterm"
    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"
    let &pastetoggle = "\e[201~"

    function XTermPasteBegin(ret)
        set paste
        return a:ret
    endfunction

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
endif

" ********** キーマップの設定 **********
nnoremap <Space>n  :NERDTree<CR>
nnoremap ; :
nnoremap  <C-c><C-c> :<C-u>nohlsearch<CR><Esc>
nnoremap Y y$
nnoremap ss :split
nnoremap sv :vsplit
nnoremap sh <C-w>h
nnoremap sl <C-w>l
nnoremap sk <C-w>k
nnoremap sj <C-w>j
nnoremap st :tabnew
nnoremap sn gt
nnoremap sp gT
" ***** キーマップここまで *****
