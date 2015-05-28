MaybsQuitView = require '../lib/maybs-quit-view'
# Grim = require 'grim'

describe "MaybsQuitView", ->
  activationPromise = null
  workspaceElement = null
  maybsQuitElement = null

  beforeEach ->
    workspaceElement = atom.views.getView(atom.workspace)
    jasmine.attachToDOM(workspaceElement)

    waitsForPromise ->
      atom.packages.activatePackage('maybs-quit')

    runs ->
      maybsQuitElement = workspaceElement.querySelector('.maybs-quit')

  afterEach ->
    atom.packages.deactivatePackages()
    atom.packages.unloadPackages()


  describe "when the maybs-quit package is load", ->
    it "keystroke is defined", ->
      expect(atom.keymaps.findKeyBindings(keystrokes:'ctrl-q')).toHaveLength 2
      expect(atom.keymaps.findKeyBindings(keystrokes:'ctrl-q')[1].command).toBe 'maybs-quit:toggle'

  describe "when the maybs-quit:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(maybsQuitElement).not.toBeVisible()
      atom.commands.dispatch workspaceElement, 'maybs-quit:toggle'

      expect(maybsQuitElement).toBeVisible()
      atom.commands.dispatch workspaceElement, 'maybs-quit:toggle'
      expect(maybsQuitElement).not.toBeVisible()
