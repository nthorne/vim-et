" This file contains python specific settings for the et plugin
"
" Last Change:  2015-07-21
" Maintainer:   Niklas Thörne  <notrupertthorne@gmail.com>
"
" License:      Copyright (C) 2015 Niklas Thörne
"
" This file is part of et.
"
" et is free software: you can redistribute it and/or modify
" it under the terms of the GNU General Public License as published by
" the Free Software Foundation, either version 3 of the License, or
" (at your option) any later version.
"
" et is distributed in the hope that it will be useful,
" but WITHOUT ANY WARRANTY; without even the implied warranty of
" MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
" GNU General Public License for more details.
"
" You should have received a copy of the GNU General Public License
" along with et.  If not, see <http://www.gnu.org/licenses/>.


" Only load this plugin once
if &cp || exists("b:did_et_plugin")
  finish
endif
let b:did_et_plugin = 1
if v:version < 700
  echoerr "et: This plugin has only been tested with vim >= 7. Please update"
  finish
endif

" Set a sane default for g:etTemplatePath, if not set.
if !exists("g:etTemplatePath")
  let g:etTemplatePath = "~/.vim/templates/"
endif

" Define the ET command, and its custom completion function.
command! -complete=customlist,AllTemplates -nargs=1 ET :call LoadEvalTemplates('<args>')

""" }}}
""" Plugin implementation {{{
"""
function! LoadEvalTemplates(template)
  " empty the buffer
  exec 'silent! u 1 | silent! u'

  " read the template file..
  exec '0r '.g:etTemplatePath.a:template

  " .. and eval anything between {{ and }}
  exec '%s/{{\(.\{-\}\)}}/\=eval(submatch(1))/ge'

  " .. and then jump to the beginning of the buffer.
  exec 'normal! gg'
endfunction

function! AllTemplates(argLead, cmdLine, cursorPos)
  " expand variables and wildcards
  let s:templateDir = expand(g:etTemplatePath)
  " make a list out of all files starting with argLead
  let s:templates = split(globpath(s:templateDir, a:argLead.'*'), '\n')

  " strip the directory part away from the filename 
  return map(s:templates, 'fnamemodify(v:val,":t")')
endfunction


""" }}}
