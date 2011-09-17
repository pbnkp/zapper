ns = {}
ns.Accessors =
  idAccessors: ->
    $(@el).children("[id]").each((idx, elem) =>
      @["$#{elem.id}"] = $(elem))

ns.Model = class Model extends Backbone.Model
  _to_locals: ->
    _.extend({cid: @cid}, @attributes)


ns.Cell = class Cell extends Backbone.View
  initialize: ->
    super
    _.extend(@, arg) for arg in arguments

  render: ->
    $(@el).html(_.template(@template.html())(@model._to_locals()))
    @

ns.View = class View extends ns.Cell
  initialize: ->
    super
    _.extend(@, ns.Accessors)
    @.idAccessors()

ns.CollectionView = class View extends ns.View

  render: ->
    content = _(@model).each (x) =>
      cell = new Cell(template: @partial, model: x)
      cell.render()
      @el.append(cell.el)
    @

root = @
root.Skull = ns
