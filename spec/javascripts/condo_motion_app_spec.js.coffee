describe "CondoMotionApp", ->
    it "passes a sanity test", ->
        app = new CmoBackbone()
        expect(app.sanity()).toEqual(true)