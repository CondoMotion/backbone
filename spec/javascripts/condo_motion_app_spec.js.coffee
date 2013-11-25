describe "CondoMotionApp", ->
    it "passes a sanity test", ->
        app = new Backbone()
        expect(app.sanity()).toEqual(true)