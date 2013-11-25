describe "CondoMotionApp", ->
    it "passes a sanity test", ->
        app = new CondoMotionApp()
        expect(app.sanity()).toEqual(true)