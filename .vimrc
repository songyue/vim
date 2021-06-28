
" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2017 Sep 20
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif


"   ```vim
   set nocompatible              " 去除VI一致性,必须
   filetype on                  " 必须

   " 设置包括vundle和初始化相关的runtime path
   set rtp+=~/.vim/bundle/Vundle.vim
   call vundle#begin()
   " 另一种选择, 指定一个vundle安装插件的路径
   "call vundle#begin('~/some/path/here')

   " 让vundle管理插件版本,必须
   Plugin 'VundleVim/Vundle.vim'

   " 以下范例用来支持不同格式的插件安装.
   " 请将安装插件的命令放在vundle#begin和vundle#end之间.
   " Github上的插件
   " 格式为 Plugin '用户名/插件仓库名'
   Plugin 'tpope/vim-fugitive'
   " 来自 http://vim-scripts.org/vim/scripts.html 的插件
   " Plugin '插件名称' 实际上是 Plugin 'vim-scripts/插件仓库名' 只是此处的用户名可以省略
   Plugin 'L9'
   " 由Git支持但不再github上的插件仓库 Plugin 'git clone 后面的地址'
   Plugin 'git://git.wincent.com/command-t.git'
   " 本地的Git仓库(例如自己的插件) Plugin 'file:///+本地插件仓库绝对路径'
   "Plugin 'file:///home/gmarik/path/to/plugin'
   " 插件在仓库的子目录中.
   " 正确指定路径用以设置runtimepath. 以下范例插件在sparkup/vim目录下
   Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
   " 安装L9，如果已经安装过这个插件，可利用以下格式避免命名冲突
   "Plugin 'ascenator/L9', {'name': 'newL9'}
   Plugin 'scrooloose/nerdtree'
   Plugin 'Xuyuanp/nerdtree-git-plugin'
   Plugin 'nerdtree-ack'
   Plugin 'terryma/vim-multiple-cursors'
   Plugin 'liuchengxu/eleline.vim'
   " vim debug 插件，支持DBGP的所有语言
   Plugin 'vim-vdebug/vdebug'
   Plugin 'VimIM'
   " 自动刷新文件
   Plugin 'djoshea/vim-autoread'
   " ctrl + p 搜索文件
   Plugin 'ctrlp.vim'
   " 基于 ctags：
"   Plugin 'vim-scripts/TagHighlight'
"   Plugin 'xolox/vim-misc'
"   Plugin 'xolox/vim-easytags'
  " php语法补全 
   "Plugin 'shawncplus/phpcomplete.vim'
   " vim-phpstan php静态检测 
   "Plugin 'phpstan/vim-phpstan'
   Plugin 'jistr/vim-nerdtree-tabs'
   " vue语法高亮插件
   "Plugin 'posva/vim-vue'
   " 补全插件
   Plugin 'neoclide/coc.nvim', {'branch': 'release'}
   " 你的所有插件需要在下面这行之前
   call vundle#end()            " 必须
   filetype plugin indent on    " 必须 加载vim自带和插件相应的语法和文件类型相关脚本
   " 忽视插件改变缩进,可以使用以下替代:
   "filetype plugin on
   "
   " 简要帮助文档
   " :PluginList       - 列出所有已配置的插件
   " :PluginInstall    - 安装插件,追加 `!` 用以更新或使用 :PluginUpdate
   " :PluginSearch foo - 搜索 foo ; 追加 `!` 清除本地缓存
   " :PluginClean      - 清除未使用插件,需要确认; 追加 `!` 自动批准移除未使用插件
   "
   " 查阅 :h vundle 获取更多细节和wiki以及FAQ
   " 将你自己对非插件片段放在这行之后
"   ```
"   vim启动时自动打开NERDTree
"autocmd vimenter * NERDTree
" 配置快捷键映射： Ctrl+n 执行 :NERDTreeToggle
"map <C-h> :NERDTreeToggle<CR>
" 通过插件实现新开tab时自动同步NERDTree 状态
map <C-h> :NERDTreeTabsToggle<CR>
" 当只剩下一个窗口并且是nerdtree插件时，推出vim编辑器
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 水平切割和垂直切割窗口快捷键
"map <C-h> :sp<CR>
"<F2>设置是否显示行号
nnoremap <silent> <F2> :set number!<CR>
"空格打开关闭折叠
nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>
"禁用鼠标模式
set mouse=
" 禁止生成临时文件
set nobackup
" 自动刷新
set autoread
" 自动保存
set autowrite
" 空格替换tab 
set expandtab
" 设置缩进
set tabstop=4
set softtabstop=4
" 自动缩进长度为4个空格 
set shiftwidth=4
" 显示行号
set nu
" 高亮当天行
set cul
set cuc
"color desert     " 设置背景主题  
color ron     " 设置背景主题  
"color torte     " 设置背景主题  
"set guifont=Courier_New:h10:cANSI   " 设置字体  
"autocmd InsertLeave * se nocul  " 用浅色高亮当前行  
autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
"set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  
"set foldenable      " 允许折叠  
""set foldmethod=manual   " 手动折叠  
set foldmethod=indent " 手动折叠  

"set ignorecase " 搜索忽略大小写
"set noignorecase " 搜索大小写敏感
set ignorecase smartcase " 智能匹配大小写,如果输入字符包含大写,则搜索结果不包含无大写的内容;输入小写则大小写不敏感
"   模式                    匹配    
"   word                word、Word、WORD、WoRd 等。
"   Word                Word
"   WORD                WORD
"   WoRd                WoRd
"
"
"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.php,*.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\#########################################################################") 
        call append(line("."), "\# File Name: ".expand("%")) 
        call append(line(".")+1, "\# Author: songyue") 
        call append(line(".")+2, "\# mail: songyue118@gmail.com") 
        call append(line(".")+3, "\# Created Time: ".strftime("%c")) 
        call append(line(".")+4, "\#########################################################################") 
        call append(line(".")+5, "\#!/bin/bash") 
     endif
     if &filetype == 'php' 
        call append(line("*"), "<?php") 
        call append(line("*")+1, "/**") 
        call append(line("*")+2, " * File Name: ".expand("%")) 
        call append(line("*")+3, " * Author: songyue") 
        call append(line("*")+4, " * mail: songyue118@gmail.com") 
        call append(line("*")+5, " * Created Time: ".strftime("%c")) 
        call append(line("*")+6, " */") 
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "    > File Name: ".expand("%")) 
        call append(line(".")+1, "    > Author: songyue") 
        call append(line(".")+2, "    > Mail: songyue@gmail.com") 
        call append(line(".")+3, "    > Created Time: ".strftime("%c")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 

let g:debuggerMaxDetp = 5
let g:debuggerPort = 8800
"let g:eleline_slim = 1

" vdebug set xdebug port 8800
if !exists('g:vdebug_options')
  let g:vdebug_options = {}
endif
let g:vdebug_options.port = 8800 
" 输出debug内容到文件
":VdebugOpt debug_file ~/vdebug.log
":VdebugOpt debug_file_level 2

:let g:vimim_cloud = 'google,sogou,baidu,qq'   
:let g:vimim_map = 'tab_as_gi'   
" :let g:vimim_mode = 'dynamic'   
" :let g:vimim_mycloud = 0   
 :let g:vimim_plugin = '/home/songyue/.vim/bundle'   
" :let g:vimim_punctuation = 2   
" :let g:vimim_shuangpin = 0   
" :let g:vimim_toggle = 'pinyin,google,sogou' 
" phpstan 配置分析级别,默认为 2 
"let g:phpstan_analyse_level = 4


" ==============
autocmd BufWritePost *.php exec ":call PHPSyntaxCheck()"

if !exists('g:PHP_SYNTAX_CHECK_BIN')
    let g:PHP_SYNTAX_CHECK_BIN = 'php'
endif

fun PHPSyntaxCheck()
    let result = system(g:PHP_SYNTAX_CHECK_BIN.' -l -n '.expand('%'))
    if (stridx(result, 'No syntax errors detected') == -1)
        echohl WarningMsg | echo result | echohl None 
    endif
endfun

"  autocmd BufWritePre,FileWritePre *.php   ks|call LastMod()|'s
"  fun LastMod()
"    if line("$") > 20
"      let l = 20
"    else
"      let l = line("$")
"    endif
"    exe "1," . l . "g/Last modified: /s/Last modified: .*/Last modified: " .
"    \ strftime("%Y %b %d")
"  endfun
"

" vue 语法高亮
au BufRead,BufNewFile *.vue set filetype=html

