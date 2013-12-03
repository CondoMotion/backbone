Plan.destroy_all
plans = Plan.create([{ name: 'monthly', amount: 25, interval: 'month' }, { name: 'annual', amount: 20, interval: 'year' }])