" Based off of https://gist.github.com/450906#file_view_image_menuitem.vim
" changes: add pdf to allowed file types
"          open in Preview
"
"guard against sourcing the script twice
if exists("g:loaded_nerdtree_view_image_menuitem")
    finish
endif
let g:loaded_nerdtree_view_image_menuitem = 1

"if eog isnt installed, bail
" not interested in eye of gnome
" probably change to Preview.app
"if !executable("eog")
"    finish
"endif

"add a menu separator (a row of dashes) before our new menu item
call NERDTreeAddMenuSeparator({
    \ 'isActiveCallback': 'NERDTreeViewImageMenuitemEnabled'})

"add the main menu item
call NERDTreeAddMenuItem({
    \ 'text': '(v)iew file',
    \ 'shortcut': 'v',
    \ 'isActiveCallback': 'NERDTreeViewImageMenuitemEnabled',
    \ 'callback': 'NERDTreeViewImageMenuItem' })

"we only want the menu item to be displayed if the current
"node is an image file
function! NERDTreeViewImageMenuitemEnabled()
    let p = g:NERDTreeFileNode.GetSelected().path
    return !p.isDirectory &&
         \ p.str() =~ '\c\.\(jpeg\|jpg\|gif\|png\|bmp\|tiff\|pdf\|ico\)$'
endfunction

"open the file the cursor is on in eog
function! NERDTreeViewImageMenuItem()
    let n = g:NERDTreeFileNode.GetSelected()
    let p = n.path.str({'escape': 1})
    call system("open -a Preview " . p)
endfunction
