(function(){!function(t){return _.extend(t.Marionette.Application.prototype,{navigate:function(r,e){return null==e&&(e={}),"/"===r.charAt(0)&&(r="#"+r),t.history.navigate(r,e)},getCurrentRoute:function(){var r;return r=t.history.fragment,_.isEmpty(r)?null:r},startHistory:function(){return t.history?t.history.start():void 0},register:function(t,r){return null==this._registry&&(this._registry={}),this._registry[r]=t},unregister:function(t,r){return delete this._registry[r]},resetRegistry:function(){var t,r,e,i,n;i=this.getRegistrySize(),n=this._registry;for(r in n)t=n[r],t.region.close();return e="There were "+i+" controllers in the registry. There are now "+this.getRegistrySize(),this.getRegistrySize>0?console.warn(e,this._registry):console.log(e)},getRegistrySize:function(){return _.size(this._registry)}})}(Backbone)}).call(this);