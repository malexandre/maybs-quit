{SelectListView, $$} = require 'atom'

module.exports =
class MaybsQuitView extends SelectListView
  activate: ->
    new MaybsQuitView

  initialize: ->
    super
    @addClass('maybs-quit overlay from-top')
    atom.workspaceView.command "maybs-quit:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  getFilterKey: ->
    'title'

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @cancel()
    else
      @setItems([
        { title: 'Quit all atom windows', action: 'application:quit' },
        { title: 'Close current tab', action: 'core:close' },
        { title: 'Close current atom window', action: 'window:close' }
        { title: 'Cancel' }
      ])
      atom.workspaceView.append(this)
      @focusFilterEditor()

  viewForItem: ({title, action}) ->
    $$ ->
      @li =>
        @span title

  confirmed: ({title, action}) ->
    @cancel()
    if action
      for event in atom.commands.findCommands({ target: atom.workspaceView[0] })
        if event.name is action
          if event.jQuery
            atom.workspaceView.trigger event.name
          else
            atom.workspaceView[0].dispatchEvent(new CustomEvent(event.name, bubbles: true, cancelable: true))
          break
