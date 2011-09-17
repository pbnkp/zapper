class Channel extends Skull.Model

class ChannelsCollection extends Backbone.Collection
  constructor: ->
    super
    @model = Channel
    @url = "/json"

$ ->
  #channels = new ChannelsCollection()
  #$.when(channels.fetch()).then (data) ->
  #  cv = new Skull.View({el: $("#channel"), model: _.head(channels.models)})
  #  cv.render()

  channels = new ChannelsCollection()
  $.when(channels.fetch()).then (data) ->
    cv = new Skull.CollectionView({partial: $("#channel"), el: $("#channels"), model: channels.models})
    cv.render()
