# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create([{name: 'business1', role: 'business'}, {name: 'business2', role: 'business'}, {name: 'business3', role: 'business'}, {name: 'charity1', role: 'charity'}, {name: 'charity2', role: 'charity'}, {name: 'charity3', role: 'charity'},  {name: 'driveradmin1', role: 'driver admin'}, {name: 'driveradmin2', role: 'driver admin'}, {name: 'driver1', role: 'driver', driver_admin_id: '7'}, {name: 'driver2', role: 'driver', driver_admin_id: '7'}, {name: 'driver3', role: 'driver', driver_admin_id: '8'}, {name: 'admin', role: 'admin'}])

Order.create([{pickup_start: Time.current, pickup_end: Time.current + 30.minutes}, {pickup_start: Time.current + 15.minutes, pickup_end: Time.current + 45.minutes, dropoff_end: Time.current + 100.minutes, picked_up: Time.now + 75.minutes, transit: true, ready_claim: false}, {pickup_start: Time.current + 15.minutes, pickup_end: Time.current + 45.minutes, dropoff_end: Time.current + 100.minutes, picked_up: Time.now + 75.minutes, awaiting_pick: true, ready_claim: false}, {pickup_start: Time.current + 15.minutes, pickup_end: Time.current + 45.minutes, dropoff_end: Time.current + 100.minutes, picked_up: Time.current + 80.minutes, dropped_off: Time.current + 90.minutes, ready_claim: false, complete: true}])
