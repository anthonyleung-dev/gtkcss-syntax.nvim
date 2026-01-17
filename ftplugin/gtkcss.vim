" GTK CSS filetype plugin
" Language: GTK CSS

if exists("b:did_ftplugin")
    finish
endif
let b:did_ftplugin = 1

" Set comment string for commenting plugins
setlocal commentstring=/*\ %s\ */
setlocal comments=s1:/*,mb:*,ex:*/

" Indentation settings
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal expandtab

" Enable CSS omni completion
setlocal omnifunc=csscomplete#CompleteCSS

" Set formatoptions
setlocal formatoptions-=t
setlocal formatoptions+=croql

" Undo settings when switching filetype
let b:undo_ftplugin = "setlocal commentstring< comments< tabstop< shiftwidth< softtabstop< expandtab< omnifunc< formatoptions<"
