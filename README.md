# vim-mode-plus-project-find-from-search

Seamless flow from vmp's search to find-and-replace's project-find.

1. Start search by `/` or `?`.
2. Press `cmd-enter`. (You need to set keymap).
3. Project-find results pane shows up.

If you like this package, you'd also like [project-find-navigation](https://atom.io/packages/project-find-navigation).

![gif](https://raw.githubusercontent.com/t9md/t9md/840920e51a91276b60b22be36fc59f87397eec04/img/vim-mode-plus/vmp-project-find-from-search.gif)

# Keymap

No default keymap.
Set this in your `keymap.cson`.

```coffeescript
'atom-text-editor.vim-mode-plus-search':
  'cmd-enter': 'vim-mode-plus-user:project-find-from-search'
```
