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

  activate: () ->
    atom.commands.add('atom-workspace', 'alignment', ->
      plugin.align(atom.workspace.getActiveEditor())
    )

  align: (editor) ->
    return if not editor

    editor.getSelections().forEach((selection) ->
      plugin.alignSelection(editor, selection)
    )

  alignSelection: (editor, selection) ->
    editor.transact(->
      selectionRange = selection.getBufferRange()

      startRow    = selectionRange.start.row
      startColumn = 0
      endRow      = selectionRange.end.row
      endColumn   = editor.lineLengthForBufferRow(selectionRange.end.row)
      range       = new Range([startRow, startColumn], [endRow, endColumn])
      text        = editor.getTextInBufferRange(range)
      align       = alignment(text)

      return if !align[1].length

      selection.clear()
      editor.setTextInBufferRange(range, align[0])

      align[1].forEach((position) ->
        editor.addCursorAtBufferPosition([startRow + position[0], position[1]])
      )

      selection.destroy()
    )
