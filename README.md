# atom-vim-mode-plus-project-fiind-from-search

Seamless flow from vmp's search to find-and-replace's project-find

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
