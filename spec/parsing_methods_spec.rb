require "parsing_methods"

describe "input_parse" do
	it 'returns an array of driver and trip structs when given text file input lines' do
		input = "Driver Dan\nTrip Dan 07:15 07:45 17.3"
		driver_data, trip_data = input_parse(input)
		driver_data = driver_data[0]
		trip_data = trip_data[0]
		expect(driver_data.driver).to eq('Dan')
		expect(driver_data.total_distance).to be_nil
		expect(driver_data.avg_speed).to be_nil
		expect(trip_data.driver).to eq('Dan')
		expect(trip_data.distance).to eq(17.3)
		expect(trip_data.hours_driven).to eq(0.5)
	end
end


describe "line_parse" do
	it 'returns driver struct when the first line segment is "Driver"' do
		type, driver = line_parse(['Driver', 'Dan'])
		expect(type).to eq('Driver')
		expect(driver.driver).to eq('Dan')
		expect(driver.total_distance).to be_nil
		expect(driver.avg_speed).to be_nil
	end
	it 'returns trip struct when the first line segment is "Trip"' do
		type, trip = line_parse(['Trip','Dan','07:15','07:45','17.3'])
		expect(type).to eq('Trip')
		expect(trip.driver).to eq('Dan')
		expect(trip.distance).to eq(17.3)
		expect(trip.hours_driven).to eq(0.5)
	end
	it 'returns nil when not passed a driver or trip' do
		type, driver = line_parse(['nope','driver'])
		expect(type).to be_nil
		expect(driver).to be_nil
	end
	it 'returns nil for trips below or above the speed threshold' do
		type, trip = line_parse(['Trip', 'Bob', '05:00', '05:05', '100.0'])
		expect(type).to be_nil
		expect(trip).to be_nil
		type, trip = line_parse(['Trip', 'Bob', '06:00', '07:00', '1.0'])
		expect(type).to be_nil
		expect(trip).to be_nil
	end
end

describe "hour_difference" do
	it 'returns the number of hours between two hh::mm timestamps' do
		diff = hour_difference('07:15','07:45')
		expect(diff).to eq(0.5)
	end
end

describe "time_to_hours" do
	it 'converts a string "hh:mm" to number of hours"'do
		hours = time_to_hours('07:15')
		expect(hours).to eq(7.25)
	end
end

describe "speed check" do
	it 'returns false for speeds outside the range' do
		speed_b5 = speed_check(4.99)
		speed_a100 = speed_check(100.01)	
		expect(speed_b5).to be false
		expect(speed_a100).to be false
	end
	it 'returns true for speeds inside the range' do
		speed_5 = speed_check(5)
		speed_50 = speed_check(50)
		speed_100 = speed_check(100)
		expect(speed_5).to be true
		expect(speed_50).to be true
		expect(speed_100).to be true
	end
end

describe "trip_aggregate" do
	it 'returns the total distance and average speed for the driver passed in' do
		test_driver = Driver.new('Sam')
		test_trip_1 = Trip.new('Sam', 17.2,0.5)
		test_trip_2 = Trip.new('Sam', 21.8, 1/3.to_f)
		test_trip_3 = Trip.new('Billy', 42.0, 0.25)
		all_trips = [test_trip_1,test_trip_2,test_trip_3]
		distance_check, speed_check = trip_aggregate(test_driver,all_trips)
		expect(distance_check).to be_within(0.001).of(39.0)
		expect(speed_check).to be_within(0.001).of(46.8)		
	end
	it 'returns 0 distance and nil speed when the driver has no trips' do
		test_driver = Driver.new('Al')
		test_trip_1 = Trip.new('Sam', 17.2,0.5)
		test_trip_2 = Trip.new('Sam', 21.8, 1/3.to_f)
		test_trip_3 = Trip.new('Billy', 42.0, 0.25)
		all_trips = [test_trip_1,test_trip_2,test_trip_3]
		distance_check, speed_check = trip_aggregate(test_driver,all_trips)
		expect(distance_check).to eq(0)
		expect(speed_check).to be_nil
	end
end

describe "full_trip_aggregate" do
	it 'adds aggregate information for all drivers' do
		test_driver_1 = Driver.new('Al')
		test_driver_2= Driver.new('Sam')
		test_trip_1 = Trip.new('Sam', 17.2,0.5)
		test_trip_2 = Trip.new('Sam', 21.8, 1/3.to_f)
		test_trip_3 = Trip.new('Billy', 42.0, 0.25)
		driver_data = [test_driver_1, test_driver_2]
		trip_data = [test_trip_1, test_trip_2, test_trip_3]
		full_trip_aggregate(driver_data, trip_data)
		d1 = driver_data[0]
		d2 = driver_data[1]
		expect(d1.total_distance).to eq(0)
		expect(d1.avg_speed).to be_nil
		expect(d2.total_distance).to be_within(0.001).of(39.0)
		expect(d2.avg_speed).to be_within(0.001).of(46.8)
	end
end

describe "driver_sort" do
	it 'sorts the driver data descending by total distance driven' do
		test_driver_1 = Driver.new('Sam',39.0,47.0)
		test_driver_2 = Driver.new('Al',0.0,0.0)
		test_driver_3 = Driver.new('Billy',42.0,30.0)
		driver_data = [test_driver_1, test_driver_2, test_driver_3]
		sorted_data = driver_sort(driver_data)
		d1 = sorted_data[0].driver
		d2 = sorted_data[1].driver
		d3 = sorted_data[2].driver
		expect(d1).to eq('Billy')
		expect(d2).to eq('Sam')
		expect(d3).to eq('Al')
	end
end

describe "print_format" do
	it 'creates a string like "driver: distance miles @ avg_speed mph" when is not nill. It also rounds to integer' do
		driver_data = Driver.new('Dan', 39.1,46.92)
		print_test = print_format(driver_data)
		expect(print_test).to eq('Dan: 39 miles @ 47 mph')
	end
	it 'creates a sting like "driver: distance miles" when avg_speed is nil' do
		driver_data = Driver.new('Dan',30.4,nil)
		print_test = print_format(driver_data)
		expect(print_test).to eq('Dan: 30 miles')
	end
end