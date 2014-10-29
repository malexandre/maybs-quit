{WorkspaceView} = require 'atom'
MaybsQuit = require '../lib/maybs-quit'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "MaybsQuit", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('maybs-quit')

  describe "when the maybs-quit:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.maybs-quit')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'maybs-quit:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.maybs-quit')).toExist()
        atom.workspaceView.trigger 'maybs-quit:toggle'
        expect(atom.workspaceView.find('.maybs-quit')).not.toExist()
