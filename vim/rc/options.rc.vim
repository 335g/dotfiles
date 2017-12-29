
set sh=zsh                          "デフォルトで起動するのはzsh
set enc=utf-8
set fenc=utf-8
set fencs=iso-2022-jp,euc-p,cp932
set incsearch                       "インクリメンタルサーチを有効にする
set ignorecase                      "大文字小文字を区別しない
set smartcase                       "大文字で検索されたら対象を大文字限定にする
set wrapscan                        "最後まで検索したら最初に戻る
set hlsearch                        "検索結果をハイライト表示する
set smartindent                     "自動インデント有効化
set autoindent                      "自動インデント有効化
set showmatch                       "括弧の対応をハイライト
set shiftround                      "'<'や'>'でインデントする際に'shiftwidth'の倍数に丸める
set infercase                       "補完時に大文字小文字を区別しない
set virtualedit=all                 "カーソルを文字が存在しない部分でも動けるようにする
set hidden                          "バッファを閉じる代わりに隠す (Undo履歴を残すため)
set switchbuf=useopen               "新しく開く代わりにすでに開いてあるバッファを開く
set ruler                           "ルーラー
set number                          "行番号
set list                            "不可視文字(TAB, EOB)
set wrap                            "長いテキストの折り返し
set showmatch                       "対応する括弧などをハイライト表示する
set matchtime                       "対応括弧のハイライト表示を3秒にする
set matchpairs& matchpairs+=<:>     "対応括弧に'<'と'>'のペアを追加
set listchars=eol:¬,tab:›\
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab                       "TABをSPACEに置き換える
set cursorline                      "カーソルライン
set title                           "タイトル
set showcmd                         "ステータスラインにコマンドを表示
set laststatus=2                    "ステータスラインを常に表示
set backspace=indent,eol,start      "バックスペースでなんでも削除可能に
"set filetype
