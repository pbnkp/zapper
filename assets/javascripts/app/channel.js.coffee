Channel = Skull.Model.extend({})

ChannelsCollection = Backbone.Collection.extend({
   model: Channel,
   url: "/json"
})

$ ->
  channels = new ChannelsCollection()
  $.when(channels.fetch()).then (data) ->
    cv = new Skull.View({el: $("#channel"), model: _.head(channels.models)})
    cv.render()
