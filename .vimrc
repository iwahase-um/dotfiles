"------------------------
" vim configuration for mac
" 2018/01/18
"------------------------

" for syntastic 2018/03/06 
"execute pathogen#infect()

"------  Charset Init  ------
" 文字コードの自動認識 {{{
source ~/.vim/recognize_charcode.vim
set encoding=utf-8
scriptencoding utf-8
"------
"#------ plugin with NeoBundle BEGIN 
set runtimepath^=~/.vim/bundle/ctrlp.vim

set nocompatible
filetype plugin indent off

if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim
endif

"" NeoBundleをNeoBundleで管理したい 下記のbegin end ブロックの間にインストールしたい プラグインを記述する
call neobundle#begin(expand('~/.vim/bundle'))
" これは必須のため必ず記載
NeoBundleFetch 'Shougo/neobundle.vim'

" vimproc 2016/09/29 {{{
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make',
			\     'linux' : 'make',
			\     'unix' : 'gmake',
			\    },
			\ }
" }}}
" 2016/07/07 file managerのついか 
NeoBundle 'scrooloose/nerdtree'
" 2017/06/28 taglist srcexpl nerdtree {{{
NeoBundle 'Trinity'
" }}}
NeoBundle 'rhysd/accelerated-jk'
" " オムニ補完 Ctrl+x, Ctrl+oでモジュール・メソッドを補完
NeoBundle "c9s/perlomni.vim"
NeoBundle "mattn/perlvalidate-vim.git"
" " シンタックスを強化
NeoBundle "vim-perl/vim-perl"
NeoBundle "smartchr"
NeoBundle 'petdance/vim-perl'
NeoBundle 'hotchpotch/perldoc-vim'
NeoBundle 'thinca/vim-quickrun'
" 2016/12/13
NeoBundle 'LeafCage/yankround.vim'         " ヤンク履歴を管理
NeoBundle 'easymotion/vim-easymotion'      " 見えている場所に素早く移動
NeoBundle 'kana/vim-niceblock'             " ビジュアルモードのI,Aの挙動を矩形選択に
NeoBundle 'kana/vim-submode'               " 連打で便利に
NeoBundle 'rhysd/clever-f.vim'             " fの検索後，f連打で次の一致箇所へ
NeoBundle 'sjl/gundo.vim'                  " undo履歴の可視化
NeoBundle 'terryma/vim-expand-region'      " 選択範囲の拡大・縮小
NeoBundle 'thinca/vim-visualstar'          " ビジュアル選択した文字列を検索
" 2016/09/30 database manaagement
NeoBundle 'vim-scripts/dbext.vim'
" 2018/03/06 cheat sheet plugin
NeoBundle 'reireias/vim-cheatsheet'
" 2018/03/06 
NeoBundle 'itchyny/lightline.vim'

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

let g:neocomplcache_ctags_arguments_list = {
     \ 'perl' : '-R -h ".pm"'
     \ }

"let g:neocomplcache_snippets_dir = "~/.vim/snippets"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
     \ 'default'    : '',
     \ 'perl'       : $HOME . '/.vim/dict/perl.dict'
     \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
     let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" for snippets
imap <expr><C-k> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : "\<C-n>"
smap <C-k> <Plug>(neocomplcache_snippets_expand)

call neobundle#end()


filetype plugin indent on

" method below checks uninstalled plugins
NeoBundleCheck

"#------ plugin with NeoBundle END
let g:accelerated_jk_acceleration_table = [10,5,3]
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

" 2018/03/06 cheat sheet file path
let g:cheatsheet#cheat_file = '~/.vimcheatsheet.md'

"set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
" status line {{{
set statusline=[%n]\        " バッファ番号
set statusline+=%F\         " 絶対ファイル名
set statusline+=%m\         " バッファ状態[+]
set statusline+=%r          " 読み取り専用フラグ
set statusline+=%<%=        " 右寄せ
set statusline+=%{'['.(&fenc!=''?&fenc:'?').'-'.&ff.']'}\   " フォーマット＆文字コード
set statusline+=%y\         " タイプ
set statusline+=%4l,%2c\    " 行、列
set statusline+=%3p%%\      " 何％
set laststatus=2
" 設定フォーマット
" %< - 行が長すぎるときに切り詰める位置
" %f - ファイル名（相対パス）
" %F - ファイル名（絶対パス）
" %t - ファイル名（パス無し)
" %m - 修正フラグ （[+]または[-]）
" %r - 読み込み専用フラグ（[RO]）
" %h - ヘルプバッファ
" %w - preview window flag
" %{'['.(&fenc!=''?&fenc:&enc).']['.&fileformat.']'} - fileencodingとfileformatを表示
" %= - 左寄せと右寄せ項目の区切り（続くアイテムを右寄せにする）
" %l - 現在のカーソルの行番号
" %L - 総行数
" %c - column番号
" %V - カラム番号
" %P - カーソルの場所 %表示
" }}}

" status line custom {{{
let g:lightline = {
      \ 'colorscheme': 'PaperColor',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }
" }}}

" 見た目の設定
syntax enable
"let g:solarized_termcolors=256
" color scheme {{{
"----------------
"set background=dark
"colorscheme solarized
"colorscheme apprentice
"colorscheme midnight2
"colorscheme kalisi
colorscheme ron 
"colorscheme iceberg 
"----------------
" }}}

set cmdheight=1       " コマンド行の行数
set diffopt+=vertical " diffは左右に並べる
set t_Co=256
"hi CursorLine   term=reverse cterm=none ctermbg=242
" set cursor color 2015/04/15
"set cursorline
"set cursorcolumn
" back slash(yen mark) + c will show cursorline
nnoremap <Leader>c :<C-u>setlocal cursorline!<CR>
"nnoremap <Leader>c :<C-u>setlocal cursorline! cursorcolumn!<CR>
"" Macのターミナルで全角記号の表示がずれる問題への対応                                       
set ambiwidth=double
" ignore the ignorecase option if the user went to the trouble of
set smartcase " entering uppercase characters.
set incsearch " incremental search - shows what was found
set hlsearch " highlights what it found
set guifontset=-*-fixed-medium-r-normal--16-*-*-*-c-*,*-r-*
set hidden
set nobk " do not make backup file
syntax on
set bs=2
set ts=4
set sw=4
set cindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set formatoptions-=ro " 改行時に自動コメントアウトしない
set virtualedit=block " 矩形選択で文字のない箇所にカーソル移動可
" カーソルラインがONの時、行全体をハイライトする
"hi CursorLine cterm=NONE term=reverse ctermbg=238
" カーソルラインがONの時、行番号をハイライトする
"hi CursorColumn cterm=NONE ctermbg=238 ctermfg=Red
" タブ空白改行の可視化
"set listchars=tab:»-,trail:-,eol:↲,extends:»,precedes:«,nbsp:%
"set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:% "改行コードはデフォルトの表示にする（区別がつかなくなるから）$ -> LF ^M -> CR

augroup vimrcEx
	au BufRead * if line("'\"") > 0 && line("'\"") <= line("$") |
	\ exe "normal g`\"" | endif
augroup END
    
" enables to use mouse
" set mouse=a
" set ttymouse=xterm2
" vim ctags update ctags by typing  :TagsGenerate 
" au BufReadPost,BufNewFile *.pm let g:vim_tags_project_tags_command = "ctags --languages=perl -f ~/.vim/tags/localdevjokerz.tags `pwd` 2>/dev/null &"
" set syntax on scripts which does not have shebang
autocmd BufNewFile,BufRead *.t set filetype=perl
autocmd BufNewFile,BufRead *.mpl set filetype=perl

" 自動的にコメント行を挿入しない
augroup auto_comment_off
    autocmd!
    autocmd BufEnter * setlocal formatoptions-=r
    autocmd BufEnter * setlocal formatoptions-=o
augroup END

au BufNewFile,BufRead *.php set tags+=$HOME/.vim/tags/furusato.tags
"set tags+=~/.vim/tags/furupure.tags

let g:vimfiler_as_default_explorer = 1

" Tlist settings {{{
"set tags = tag
"set tags+=~/.vim/tags/yyc_current.tags
let Tlist_Ctags_Cmd = "/usr/local/bin/ctags" " ctags commond
"let Tlist_Show_One_File = 1    " show tags only on active file
"let Tlist_Use_Right_Window = 0 " show tag list on right hand side
let Tlist_Exit_OnlyWindow = 1  " close vim if only tlist
" }}}

" ScrExpl setting {{{
" get source from https://github.com/wesleyche/SrcExpl.git
NeoBundleLazy "wesleyche/SrcExpl", {
            \ "autoload" : { "commands": ["SrcExplToggle"]}}
if ! empty(neobundle#get("SrcExpl"))
    " Set refresh time in ms
    let g:SrcExpl_RefreshTime = 1000
    " Is update tags when SrcExpl is opened
    let g:SrcExpl_isUpdateTags = 0
    " Tag update command
    let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
    " Update all tags
    function! g:SrcExpl_UpdateAllTags()
        let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase -R .'
        call g:SrcExpl_UpdateTags()
        let g:SrcExpl_updateTagsCmd = 'ctags --sort=foldcase %'
    endfunction
    " Source Explorer  Window  Height
    let g:SrcExpl_winHeight = 14
    " Mappings
    nn [srce] <Nop>
    nm <Leader>E [srce]
    nn <silent> [srce]<CR> :SrcExplToggle<CR>
    nn <silent> [srce]u :call g:SrcExpl_UpdateTags()<CR>
    nn <silent> [srce]a :call g:SrcExpl_UpdateAllTags()<CR>
    nn <silent> [srce]n :call g:SrcExpl_NextDef()<CR>
    nn <silent> [srce]p :call g:SrcExpl_PrevDef()<CR>
endif
" }}}

" plugin CtrlP configuration {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
" --- MRU mode options ---
let g:ctrlp_mruf_max = 250 " number of recently opened files I want Ctrlp toremember
let g:ctrlp_mruf_exclude = '/tmp/.*\|/temp/.*' " file types to exclude 
let g:ctrlp_mruf_include ='\.pm$\|\.pl$\|\.inc' " file types to remember
" }}}

" MRU settings {{{
" and usage
" press ENTER will open the file under cursor
" press o  will open the file with new window
" press u will update MRU file list
let MRU_Max_Entries = 100 " default 10
let MRU_Window_Height = 15 " default 8
let MRU_Exclude_Files = '^/tmp/.*\|^/var/tmp/.*'  " For Unix
" }}}

" ----------------------- Mapping  -----------------------
" vimshell setting {{{
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '
"let g:vimshell_prompt = "[".$USERNAME."@".$HOSTNAME."]> "
"let g:vimshell_secondary_prompt = "> "
"let g:vimshell_user_prompt = '"(" . getcwd() . ") --- (" . $USER . "@" . hostname() . ")"'
let g:vimshell_interactive_update_time = 10
let g:vimshell_interactive_encodings = {
\'/':'utf-8-mac',
\}
let g:vimshell_user_prompt = 'iconv(fnamemodify(getcwd(), ":~"), "utf-8-mac", "char")'
"let g:vimshell_prompt = $USERNAME."% "
" vimshell map
nnoremap <silent> vs :VimShell<CR>
nnoremap <silent> vsc :VimShellCreate<CR>
nnoremap <silent> vp :VimShellPop<CR>
" }}}

" day time auto insert {{{
" usage 挿入モード時にバックスラッシュ＋[df|dd|ddj|dt]
inoremap <Leader>df <C-R>=strftime('%Y/%m/%dT%H:%M:%S+09:00')<CR>
inoremap <Leader>dd <C-R>=strftime('%Y/%m/%d')<CR>
inoremap <Leader>ddj <C-R>=strftime('%Y年%m月%d日')<CR>
inoremap <Leader>dt <C-R>=strftime('%H:%M:%S')<CR>
" }}}

" tag jump by Ctrl+h / Ctrl+k {{{
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
" }}}

" modified 2016.09/21 type S, then type what you're looking for, a /, and what to replace it with
nmap S :%s//g<LEFT><LEFT>
vmap S :s//g<LEFT><LEFT>
" modified 2016.09/26 Edit and Reload .vimrc files
nmap <silent> <Leader>ev :e $MYVIMRC<CR>
nmap <silent> <Leader>es :so $MYVIMRC<CR>

" ---ノーマルモード--- {{{
" [Esc] + [Esc]で検索のハイライトを消す
nnoremap <Esc><Esc> :noh<CR>
" 「+」でsplitリサイズ幅を増やす
nnoremap + <C-W>k<C-W>+<C-W>p
" 「-」でsplitリサイズ幅を減らす
nnoremap - <C-W>k<C-W>-<C-W>p
" 「)」でVsplitリサイズ幅を増やす
nnoremap ) <C-W>h<C-W>><C-W>p
" 「(」でVsplitリサイズ幅を減らす
nnoremap ( <C-W>h<C-W><LT><C-W>p
" 「tn」でタブを新しく作る
nnoremap tn :<C-u>tabnew<CR>
" 「tc」でタブを閉じる
nnoremap tc :<C-u>tabclose<CR>
" 「tf」で最初のタブへ
nnoremap tf :<C-u>tabfirst<CR>
" 「tl」で最後のタブへ
nnoremap tl :<C-u>tablast<CR>
" }}}

" ---カンマコマンドモード--- {{{
" 「,」を打ってから各キーを打つと各コマンドを実行
let mapleader=","
" 「,r」：.vimrcのリロード
noremap <Leader>r :source ~/.vimrc<CR>:noh<CR>
" 「,n」：行番号表示／非表示
noremap <Leader>n :<C-u>:setlocal number!<CR>
" 「,c」：カーソルラインの表示／非表示
noremap <Leader>c :<C-u>:setlocal cursorline!<CR>
" 「,C」：カーソルカラムの表示／非表示
noremap <Leader>C :<C-u>:setlocal cursorcolumn!<CR>
" 「,l」：タブ、空白、改行などの可視化ON／OFF
noremap <Leader>l :<C-u>:setlocal list!<CR>
" 「,s」：ウィンドウを縦分割
nnoremap <Leader>s :<C-u>sp<CR>
" 「,v」：ウィンドウを横分割
nnoremap <Leader>v :<C-u>vs<CR>
" 「,S」：ウィンドウを縦分割(ファイルを指定して)
nnoremap <Leader>S :<C-u>sp <TAB>
" 「,V」：ウィンドウを横分割（ファイルを指定して）
nnoremap <Leader>V :<C-u>vs <TAB>
" 「,T」：新規タブを作成（ファイルを指定して）
nnoremap <Leader>T :<C-u>tabnew <TAB>
" 「,pt」perltidy the whole file
map ,pt <Esc>:%! perltidy -pbp<CR>
" 「,ptv」+ Enter  tidy the selected code by vim visual mode by perltidy 
map ,ptv <Esc>:'<,'>! perltidy -pbp
" 「,ph」+ Enter run php script which you are now editting
map ,ph <Esc>:! php %
" }}}

" set compiler to vim.perlcompiler when edit perl file 
autocmd FileType perl :compiler perl
" autocmd FileType perl set tags=$HOME/.vim/tags/myLib.tags
set iskeyword+=:

" Function Key {{{
nnoremap <F2> : tab tag <C-R>=expand('<cword>')<CR><CR> " Press F2 will tag jump with newtab open
"nnoremap <F3> :stj <C-R>=expand('<cword>')<CR><CR> <C-w><S-j><CR> " Press F3 will tag jump with split window
nnoremap <F3> :Cheat<CR> " Press F3 will show my vim cheat sheet
"map <F4> :!perl %<CR>
map <F4> :!php -l %<CR>
map <F5> :! perl -cw %<CR>
map <F6> :! perl %<CR>
"map <F6> :! perl -d:Trace %<CR> " debug with Devel::Trace 
map <F7> :! perl -MO=Deparse %<CR>
"nnoremap <silent> <F8> :TlistToggle<CR> " taglist
"map <F8> :TagbarToggle<CR> " taglist
"nnoremap <silent> <F8> :TlistToggle<CR>
" Open and close the Taglist separately 
nmap <F8> :TrinityToggleTagList<CR>
" Open and close the Source Explorer separately 
nmap <F9>  :TrinityToggleSourceExplorer<CR>
"nnoremap <silent> <F9> :SrcExplToggle<CR>
nmap <F10> :TrinityToggleAll<CR>
" }}}

let g:NERDTreeShowBookmarks=1
"autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
""" open NERDTree with `Ctrl+n`
map <C-n> :NERDTreeToggle<CR>
"map <C-n> :TrinityToggleNERDTree<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"" NERDTree high light {{{
"function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"	exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"	exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
"endfunction
"call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
"call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
"call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
"call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
"call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
"call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
"call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
"let g:NERDTreeDirArrows = 1
"let g:NERDTreeDirArrowExpandable  = '▶'
"let g:NERDTreeDirArrowCollapsible = '▼'
" }}}

" syntastic configuration 2018/03/06 {{{
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
"
"let g:syntastic_always_populate_loc_list = 1
"let g:syntastic_auto_loc_list = 1
"let g:syntastic_check_on_open = 1
"let g:syntastic_check_on_wq = 0
" }}}


" template fro pm {{{
function! s:pm_template()
	let path = substitute(expand('%'), '.*lib/', '', 'g')
	let path = substitute(path, '[\\/]', '::', 'g')
	let path = substitute(path, '\.pm$', '', 'g')

	call append(0, 'package ' . path . ';')
	call append(1, 'use strict;')
	call append(2, 'use warnings;')
	call append(3, 'use utf8;')
	call append(4, '')
	call append(5, '')
	call append(6, '')
	call append(7, '1;')
	call cursor(6, 0)
	" echomsg path
endfunction
autocmd BufNewFile *.pm call s:pm_template()
" }}}
