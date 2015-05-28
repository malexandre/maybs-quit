module.exports =
  activate: ->
    @stack = []
    @workspaceSubscription = atom.commands.add 'atom-workspace',
      'maybs-quit:toggle': => @createMaybsQuitView().toggle()

  deactivate: ->
    if @maybsQuitView?
      @maybsQuitView.destroy()
      @maybsQuitView = null

    if @workspaceSubscription?
      @workspaceSubscription.dispose()
      @workspaceSubscription = null

  createMaybsQuitView: ->
    unless @maybsQuitView?
      MaybsQuitView = require './maybs-quit-view'
      @maybsQuitView = new MaybsQuitView(@stack)
    @maybsQuitView
