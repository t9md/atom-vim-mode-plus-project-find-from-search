{CompositeDisposable} = require 'atom'
getEditorState = null

module.exports =
  activate: ->
    @subscription = atom.commands.add 'atom-text-editor',
      'vim-mode-plus-user:project-find-from-search': => @projectFindFromSearch()

  deactivate: ->
    @subscriptions.dispose()
    @subscriptions = null

  consumeVimModePlus: (service) ->
    {getEditorState} = service

  onDidGetPackage: (packageName, fn) ->
    if atom.packages.isPackageActive(packageName)
      fn(atom.packages.getActivePackage(packageName))
    else
      atom.packages.onDidActivatePackage (pkg) ->
        fn(pkg) if pkg.name is packageName

  getVimState: ->
    editor = atom.workspace.getActiveTextEditor()
    getEditorState(editor)

  subscribe: (args...) ->
    @subscriptions.add args...

  projectFindFromSearch: ->
    vimState = @getVimState()
    text = vimState.searchInput.editor.getText()
    vimState.searchInput.confirm()

    atom.commands.dispatch(@getVimState().editorElement, 'project-find:show')
    @onDidGetPackage 'find-and-replace', (pkg) ->
      {projectFindView} = pkg.mainModule
      projectFindView.findEditor.setText(text)
      projectFindView.confirm()
