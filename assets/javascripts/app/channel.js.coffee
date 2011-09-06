Channel = (options) ->
  new Skull.Model("Channel", options)

ChannelsCollection = Backbone.Collection.extend({
   model: Channel,
   url: "/json"
})

$ ->
  channels = new ChannelsCollection()
  $.when(channels.fetch()).then (data) ->
    cv = Skull.View({el: $("#channel"), model: _.head(channels.models)})
    cv.render()
