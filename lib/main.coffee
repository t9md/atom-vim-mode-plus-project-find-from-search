{CompositeDisposable, Emitter} = require 'atom'
getEditorState = null

module.exports =
  activate: ->
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
