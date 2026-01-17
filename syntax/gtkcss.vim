" Vim syntax file
" Language: GTK CSS (GTK3/GTK4 CSS with @define-color support)
" Maintainer: Anthony
" Based on CSS/LESS syntax with GTK-specific additions

if exists("b:current_syntax")
    finish
endif

" Load CSS syntax as base
runtime! syntax/css.vim
unlet! b:current_syntax

" GTK @define-color statement
syn match gtkCssDefineColor /@define-color\s\+/ nextgroup=gtkCssColorName
syn match gtkCssColorName /[a-zA-Z_][a-zA-Z0-9_-]*/ contained nextgroup=gtkCssColorValue skipwhite
syn match gtkCssColorValue /#[0-9a-fA-F]\{3,8\}/ contained

" GTK color variable reference @colorname
syn match gtkCssColorRef /@[a-zA-Z_][a-zA-Z0-9_-]*/

" GTK-specific functions
syn keyword gtkCssFunction alpha shade mix lighter darker contained
syn match gtkCssFunctionCall /\<\(alpha\|shade\|mix\|lighter\|darker\)\s*(/me=e-1

" GTK-specific properties
syn match gtkCssGtkProperty /-gtk-[a-zA-Z-]*/

" @import statement
syn match gtkCssImport /@import\s\+/ nextgroup=gtkCssImportPath
syn region gtkCssImportPath start=/"/ end=/"/ contained
syn region gtkCssImportPath start=/'/ end=/'/ contained

" @keyframes
syn match gtkCssKeyframes /@keyframes\s\+/ nextgroup=gtkCssAnimationName
syn match gtkCssAnimationName /[a-zA-Z_][a-zA-Z0-9_-]*/ contained

" GTK widget selectors
syn match gtkCssWidget /\<\(window\|button\|label\|entry\|textview\|treeview\|scrollbar\|scale\|progressbar\|spinner\|tooltip\|menu\|menuitem\|popover\|headerbar\|notebook\|stack\|revealer\|expander\|separator\|frame\|box\|grid\|flowbox\|listbox\|scrolledwindow\)\>/

" Highlighting groups
hi def link gtkCssDefineColor PreProc
hi def link gtkCssColorName Identifier
hi def link gtkCssColorValue Constant
hi def link gtkCssColorRef Special
hi def link gtkCssFunction Function
hi def link gtkCssFunctionCall Function
hi def link gtkCssGtkProperty Statement
hi def link gtkCssImport PreProc
hi def link gtkCssImportPath String
hi def link gtkCssKeyframes PreProc
hi def link gtkCssAnimationName Identifier
hi def link gtkCssWidget Type

let b:current_syntax = "gtkcss"
