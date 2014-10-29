MaybsQuitView = require './maybs-quit-view'

module.exports =
  maybsQuitView: null

  activate: ->
    @maybsQuitView = new MaybsQuitView()

  deactivate: ->
    @maybsQuitView.destroy()

  serialize: ->
    maybsQuitViewState: @maybsQuitView.serialize()
