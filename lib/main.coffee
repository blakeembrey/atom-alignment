alignment = require('./alignment')
{Range, TextBuffer} = require('atom')

plugin = module.exports =
  config:
    leftSeparators:
      type: 'array'
      default: [':']
      items:
        type: 'string'
    rightSeparators:
      type: 'array'
      default: ['=', '+=', '-=', '*=', '/=', '?=', '|=', '%=', '.=', '=>']
      items:
        type: 'string'
    spaceSeparators:
      type: 'array'
      default: ['=', '+=', '-=', '*=', '/=', '?=', '|=', '%=', '.=', '=>']
      items:
        type: 'string'
    ignoreSeparators:
      type: 'array'
      default: ['::']
      items:
        type: 'string'

  activate: () ->
    atom.commands.add('atom-text-editor', 'alignment', ->
      plugin.align(atom.workspace.getActiveTextEditor())
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
      endColumn   = editor.lineTextForBufferRow(selectionRange.end.row).length
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
