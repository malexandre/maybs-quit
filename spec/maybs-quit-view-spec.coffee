{WorkspaceView} = require 'atom'
MaybsQuitView = require '../lib/maybs-quit-view'
# Grim = require 'grim'

describe "MaybsQuitView", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('maybs-quit')


  # describe "when the maybs-quit package is load", ->
  #   it "does not have any deprecated calls", ->
  #     deprecations = Grim.getDeprecations()
  #     for deprecation in deprecations
  #       expect(deprecation.getStacks()[0].metadata.packageName).not.toBe 'maybs-quit'
  #     jasmine.restoreDeprecationsSnapshot()

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
