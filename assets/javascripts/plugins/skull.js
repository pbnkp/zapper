// Skull.js
// This is a little wip convention over configuration framework based on 
// the concepts explained by jicksta (Jay Phillips) on the Backbone.js Pivotal Talks.
//
// Whats there:
// - accessors of subelements

var Skull = {};

Skull.Accessors = {
  idAccessors: function() {
    console.log(this);
    that = this;

    $(this.el).children("[id]").each(function(){
      that["$" + this.id] = $(this);
    });

    this.$container = $(this.el);
  }
}

Skull.Model = function(modelName, options) {
  var self = new (Backbone.Model.extend({model_name: modelName}))(options);
  self._to_locals = function() {
    return _.extend({cid: self.cid}, self.attributes);
  };
  return self;
};

Skull.View = function() {
  var options = _.inject(arguments, function(memo, params) {
    return _.extend(memo, params);
  }, {});

  var self = new (Backbone.View.extend(options));

  _.extend(self, Skull.Accessors);

  self.idAccessors();

  self.render = function() {
    var renderedHTML = _.template(self.$template.html())(self.model._to_locals());
    self.$container.html(renderedHTML);
  }

  return self;
};
