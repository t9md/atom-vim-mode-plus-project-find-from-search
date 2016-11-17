{CompositeDisposable, Emitter} = require 'atom'
getEditorState = null

module.exports =
  activate: ->
    message = """
    ## DEPRECATED: **vim-mode-plus-project-find-from-search**
    - This package's feature was merged to vim-mode-plus's core from vim-mode-plus v0.68.0.
    - Will be unpublished soon.
    - Remove your custom keymap for this package
    - vim-mode-plus set `cmd-enter` as default keymap for macOS user.
    """.replace(/_/g, ' ')
    atom.notifications.addWarning(message, dismissable: true)

    @subscriptions = new CompositeDisposable
    @emitter = new Emitter
    @subscribe atom.commands.add 'atom-text-editor',
      'vim-mode-plus-user:project-find-from-search': =>
        if getEditorState?
          @projectFindFromSearch()
        else
          @onDidGetVimModePlus => @projectFindFromSearch()

  deactivate: ->
    @subscriptions.dispose()
    {@subscriptions, @emitter} = {}

  subscribe: (args...) ->
    @subscriptions.add args...

  onDidGetVimModePlus: (fn) ->
    @emitter.on 'did-get-vim-mode-plus', fn

  consumeVimModePlus: (service) ->
    {getEditorState} = service
    @emitter.emit 'did-get-vim-mode-plus'

  getPackage: (name, fn) ->
    new Promise (resolve) ->
      if atom.packages.isPackageActive(name)
        pkg = atom.packages.getActivePackage(name)
        resolve(pkg)
      else
        atom.packages.onDidActivatePackage (pkg) ->
          resolve(pkg) if pkg.name is name

  projectFindFromSearch: ->
    vimState = getEditorState(atom.workspace.getActiveTextEditor())
    text = vimState.searchInput.editor.getText()
    vimState.searchInput.confirm()

    atom.commands.dispatch(vimState.editorElement, 'project-find:show')
    @getPackage('find-and-replace').then (pkg) ->
      {projectFindView} = pkg.mainModule
      projectFindView.findEditor.setText(text)
      projectFindView.confirm()
