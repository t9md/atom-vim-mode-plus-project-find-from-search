# vim-mode-plus-project-find-from-search

Seamless flow from vmp's search to find-and-replace's project-find

If you like this package, you'd also like [project-find-navigation](https://atom.io/packages/project-find-navigation).

# Keymap

No default keymap.
Set this in your `keymap.cson`.

```coffeescript
'atom-text-editor.vim-mode-plus-search':
  'ctrl-o': 'vim-mode-plus-user:project-find-from-search'
```

# How to use

1. Start search by `/` or `?`.
2. Press `ctrl-o`.
3. Project-find results pane shows up.
