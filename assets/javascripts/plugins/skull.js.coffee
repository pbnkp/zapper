ns = {}
ns.Accessors =
  idAccessors: ->
    $(@el).children("[id]").each((idx, elem) =>
      @["$#{elem.id}"] = $(elem))
    @.$container = $(@el)

ns.Model = class Model extends Backbone.Model
  _to_locals: ->
    _.extend({cid: @cid}, @attributes)

ns.View = class View extends Backbone.View
  constructor: ->
    _.extend(@, arg) for arg in arguments
    _.extend(@, ns.Accessors)
    @.idAccessors()

  render: ->
    html = _.template(@$template.html())(@model._to_locals())
    @$container.html(html)

    super
    @

root = @
root.Skull = ns
