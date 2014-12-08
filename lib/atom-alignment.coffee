alignment           = require('./alignment')
{Range, TextBuffer} = require('atom')

plugin = module.exports =
  configDefaults:
    leftSeparators:
      [':']
    rightSeparators:
      ['=', '+=', '-=', '*=', '/=', '?=', '|=', '%=', '.=', '=>']
    spaceSeparators:
      ['=', '+=', '-=', '*=', '/=', '?=', '|=', '%=', '.=', '=>']
    ignoreSeparators:
      ['::']

  activate: (state) ->
    atom.workspaceView.command('alignment', '.editor', ->
      plugin.align(atom.workspace.getActiveEditor())
    )

  align: (editor) ->
    editor.getSelections()
      .forEach((selection) ->
        plugin.alignSelection(editor, selection)
      )

  alignSelection: (editor, selection) ->
    editor.transact(=>
      selectionRange = selection.getBufferRange()

      startRow    = selectionRange.start.row
      startColumn = 0
      endRow      = selectionRange.end.row
      endColumn   = editor.lineLengthForBufferRow(selectionRange.end.row)
      range       = new Range([startRow, startColumn], [endRow, endColumn])
      text        = editor.getTextInBufferRange(range)
      align       = alignment(text)

      editor.setTextInBufferRange(range, align[0])
      selection.destroy()

      align[1].forEach((position) ->
        editor.addCursorAtBufferPosition([startRow + position[0], position[1]])
      )
    )
