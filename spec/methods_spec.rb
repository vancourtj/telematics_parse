require "methods"
require "driver_model"
require "trip_model"

describe "line_parse" do
	it 'returns a new instance of the Driver class when the first line segment is "Driver"' do
		type, driver = line_parse(['Driver', 'Dan'])
		expect(type).to eq('Driver')
		expect(driver.driver_name).to eq('Dan')
	end
	it 'returns a new instance of the Trip class when the first line segment is "Trip"' do
		type, trip = line_parse(['Trip','Dan','07:15','07:45','17.3'])
		expect(type).to eq('Trip')
		expect(trip.driver_name).to eq('Dan')
		expect(trip.distance).to be_within(0.001).of(17.3)
	end
	it 'returns nil when not passed a driver or trip' do
		type, driver = line_parse(['nope','driver'])
		expect(type).to be_nil
		expect(driver).to be_nil
	end
end

describe 'class_initialization' do
    it 'returns arrays of Driver and Trips class objects when given text input'do
        input = "Driver Dan\nTrip Dan 07:15 07:45 17.3"
        driver_list, trip_list = class_initialization(input)
        d0 = driver_list[0]
        t0 = trip_list[0]
        expect(d0.driver_name).to eq('Dan')
        expect(t0.driver_name).to eq('Dan')
        expect(t0.distance).to be_within(0.001).of(17.3)
    end
end

describe 'trip_addition' do
    it 'calls the add_trip Driver class methods to connect the trip data to the driver data' do
        d1 = Driver.new('Dan')
        d2 = Driver.new('Bill')
        t1 = Trip.new('Dan','07:15','07:45','17.3')
        t2 = Trip.new('Bill','01:05','03:32','31.0')
        t3 = Trip.new('Dan','013:47','16:07','67.5')
        driver_list = [d1,d2]
        trip_list = [t1,t2,t3]
        trip_addition(driver_list,trip_list)
        expect(d1.trips.length()).to eq(2)
        expect(d2.trips.length()).to eq(1)
    end
end

describe 'driver_sort' do
    it 'sorts the driver data be descending total distance driven' do
        d1 = Driver.new('Dan')
        d2 = Driver.new('Bill')
        d3 = Driver.new('Sam')
        t1 = Trip.new('Dan','07:15','07:45','17.3')
        t2 = Trip.new('Bill','01:05','03:32','31.0')
        t3 = Trip.new('Sam','013:47','16:07','67.5')
        driver_list = [d1,d2,d3]
        trip_list = [t1,t2,t3]
        trip_addition(driver_list,trip_list)
        driver_sort(driver_list)
        expect(driver_list[0].driver_name).to eq('Sam')
        expect(driver_list[1].driver_name).to eq('Bill')
        expect(driver_list[2].driver_name).to eq('Dan')
    end
    it 'sorts the driver data alphabetically when distance is tied' do
        d1 = Driver.new('Dan')
        d2 = Driver.new('Bill')
        d3 = Driver.new('Sam')
        t1 = Trip.new('Dan','07:15','07:45','17.3')
        t2 = Trip.new('Bill','01:05','03:32','31.0')
        t3 = Trip.new('Sam','013:47','16:07','31.0')
        driver_list = [d1,d2,d3]
        trip_list = [t1,t2,t3]
        trip_addition(driver_list,trip_list)
        driver_sort(driver_list)
        expect(driver_list[0].driver_name).to eq('Bill')
        expect(driver_list[1].driver_name).to eq('Sam')
        expect(driver_list[2].driver_name).to eq('Dan')
    end
end

describe 'print_format' do
	it 'creates a string like "driver: distance miles @ avg_speed mph" when is not nill. It also rounds to integer' do
        d1 = Driver.new('Dan')
        t1 = Trip.new('Dan','07:15','07:45','17.3')
        trip_addition([d1],[t1])
		print_test = print_format(d1)
		expect(print_test).to eq('Dan: 17 miles @ 35 mph')
	end
    it 'creates a sting like "driver: distance miles" when avg_speed is nil' do
        d1 = Driver.new('Dan')
		print_test = print_format(d1)
		expect(print_test).to eq('Dan: 0 miles')
	end
end