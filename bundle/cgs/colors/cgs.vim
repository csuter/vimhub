" Vim color file
" Maintainer:	Christopher Suter <cgs1019@gmail.com>
" Last Change:	2012 Mar 14

" cgs -- for me. derived from desert256

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name="cgs"

" functions {{{
" returns an approximate grey index for the given grey level
fun <SID>grey_number(x)
  if a:x < 14
    return 0
  else
    let l:n = (a:x - 8) / 10
    let l:m = (a:x - 8) % 10
    if l:m < 5
      return l:n
    else
      return l:n + 1
    endif
  endif
endfun

" returns the actual grey level represented by the grey index
fun <SID>grey_level(n)
  if a:n == 0
    return 0
  else
    return 8 + (a:n * 10)
  endif
endfun

" returns the palette index for the given grey index
fun <SID>grey_color(n)
  if a:n == 0
    return 16
  elseif a:n == 25
    return 231
  else
    return 231 + a:n
  endif
endfun

" returns an approximate color index for the given color level
fun <SID>rgb_number(x)
  if a:x < 75
    return 0
  else
    let l:n = (a:x - 55) / 40
    let l:m = (a:x - 55) % 40
    if l:m < 20
      return l:n
    else
      return l:n + 1
    endif
  endif
endfun

" returns the actual color level for the given color index
fun <SID>rgb_level(n)
  if a:n == 0
    return 0
  else
    return 55 + (a:n * 40)
  endif
endfun

" returns the palette index for the given R/G/B color indices
fun <SID>rgb_color(x, y, z)
  return 16 + (a:x * 36) + (a:y * 6) + a:z
endfun

" returns the palette index to approximate the given R/G/B color levels
fun <SID>color(r, g, b)
  " get the closest grey
  let l:gx = <SID>grey_number(a:r)
  let l:gy = <SID>grey_number(a:g)
  let l:gz = <SID>grey_number(a:b)

  " get the closest color
  let l:x = <SID>rgb_number(a:r)
  let l:y = <SID>rgb_number(a:g)
  let l:z = <SID>rgb_number(a:b)

  if l:gx == l:gy && l:gy == l:gz
    " there are two possibilities
    let l:dgr = <SID>grey_level(l:gx) - a:r
    let l:dgg = <SID>grey_level(l:gy) - a:g
    let l:dgb = <SID>grey_level(l:gz) - a:b
    let l:dgrey = (l:dgr * l:dgr) + (l:dgg * l:dgg) + (l:dgb * l:dgb)
    let l:dr = <SID>rgb_level(l:gx) - a:r
    let l:dg = <SID>rgb_level(l:gy) - a:g
    let l:db = <SID>rgb_level(l:gz) - a:b
    let l:drgb = (l:dr * l:dr) + (l:dg * l:dg) + (l:db * l:db)
    if l:dgrey < l:drgb
      " use the grey
      return <SID>grey_color(l:gx)
    else
      " use the color
      return <SID>rgb_color(l:x, l:y, l:z)
    endif
  else
    " only one possibility
    return <SID>rgb_color(l:x, l:y, l:z)
  endif
endfun

" returns the palette index to approximate the 'rrggbb' hex string
fun <SID>rgb(rgb)
  let l:r = ("0x" . strpart(a:rgb, 0, 2)) + 0
  let l:g = ("0x" . strpart(a:rgb, 2, 2)) + 0
  let l:b = ("0x" . strpart(a:rgb, 4, 2)) + 0

  return <SID>color(l:r, l:g, l:b)
endfun

" sets the highlighting for the given group
fun <SID>X(group, fg, bg, attr)
  if a:fg != ""
    exec "hi " . a:group . " guifg=#" . a:fg . " ctermfg=" . <SID>rgb(a:fg)
  endif
  if a:bg != ""
    exec "hi " . a:group . " guibg=#" . a:bg . " ctermbg=" . <SID>rgb(a:bg)
  endif
  if a:attr != ""
    exec "hi " . a:group . " gui=" . a:attr . " cterm=" . a:attr
  endif
endfun
" }}}

call <SID>X("Normal", "ffffff", "000000", "")

" highlight groups
call <SID>X("Cursor", "708090", "f0e68c", "")
"CursorIM
"Directory
call <SID>X("DiffAdd",  "ffffff", "00aa00", "")
call <SID>X("DiffChange", "ffffff", "000000", "")
call <SID>X("DiffText",   "000000", "ffff00", "")
call <SID>X("DiffDelete", "aa0000", "aa0000", "")
"ErrorMsg
call <SID>X("VertSplit", "dddddd", "dddddd", "reverse")
call <SID>X("Folded", "ffd700", "4d4d4d", "")
call <SID>X("FoldColumn", "d2b48c", "4d4d4d", "")
call <SID>X("IncSearch", "708090", "f0e68c", "")
call <SID>X("LineNr", "888888", "222222", "")
call <SID>X("ModeMsg", "2288ff", "", "")
call <SID>X("MoreMsg", "ffffff", "", "")
call <SID>X("NonText", "444444", "000000", "bold")
call <SID>X("Question", "00ff7f", "", "")
call <SID>X("Search", "f5deb3", "cd853f", "")
call <SID>X("SpecialKey", "99cc33", "", "")
call <SID>X("Title", "cd5c5c", "", "")
call <SID>X("Visual", "6b8e23", "f0e68c", "reverse")
"VisualNOS
call <SID>X("WarningMsg", "fa8072", "", "")
"WildMenu
"Menu
"Scrollbar
"Tooltip
call <SID>X("Pmenu", "dddddd", "2288ff", "")
call <SID>X("PmenuSel", "ffffff", "66aaff", "")

" syntax highlighting groups
call <SID>X("Comment", "2288ff", "", "")
call <SID>X("Constant", "ffa0a0", "", "")
call <SID>X("Identifier", "99ff99", "", "none")
call <SID>X("Statement", "f0e66c", "", "bold")
call <SID>X("PreProc", "cc5555", "", "")
call <SID>X("Type", "55bb55", "", "bold")
call <SID>X("Special", "ffdead", "", "")
call <SID>X("Underlined", "", "", "bold")
call <SID>X("Ignore", "666666", "", "")
"Error
call <SID>X("Todo", "ff4500", "eeee00", "")
call <SID>X("MatchParen", "ffffff", "2288ff", "")

" delete functions {{{
delf <SID>X
delf <SID>rgb
delf <SID>color
delf <SID>rgb_color
delf <SID>rgb_level
delf <SID>rgb_number
delf <SID>grey_color
delf <SID>grey_level
delf <SID>grey_number
" }}}

" vim: set fdl=0 fdm=marker:
