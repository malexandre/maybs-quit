{$$, SelectListView} = require 'atom-space-pen-views'

module.exports =
class MaybsQuitView extends SelectListView
  initialize: ->
    super
    @panel = atom.workspace.addModalPanel(item: this, visible: false)
    @addClass('maybs-quit')

  cancelled: ->
    @panel.hide()

  getFilterKey: ->
    'title'

  # Tear down any state and detach
  destroy: ->
    @cancel()
    @panel.destroy()

  toggle: ->
    if @panel.isVisible()
      @cancel()
    else
      @setItems([
        { title: 'Close current atom window', action: 'window:close' }
        { title: 'Quit all atom windows', action: 'application:quit' },
        { title: 'Close current tab', action: 'core:close' },
        { title: 'Cancel' }
      ])
      @storeFocusedElement()
      @panel.show()
      @focusFilterEditor()

  viewForItem: ({title, action}) ->
    $$ ->
      @li =>
        @span title

  confirmed: ({title, action}) ->
    @cancel()
    if action
      atom.commands.dispatch atom.views.getView(atom.workspace), action
