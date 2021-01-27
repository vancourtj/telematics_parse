require "./services/functions"
require "./services/textparse"
require "./models/driver"
require "./models/trip"

describe 'class_initialization' do
    it 'returns arrays of Driver and Trips class objects when given text input' do
        input = "Driver Dan\nTrip Dan 07:15 07:45 17.3"

        driver_list, trip_list = class_initialization(input)

        driver = driver_list[0]
        trip = trip_list[0]

        expect(driver.driver_name).to eq('Dan')
        expect(trip.driver_name).to eq('Dan')
        expect(trip.distance).to be_within(0.001).of(17.3)

    end
end

describe 'trip_addition' do
    it 'calls the add_trip Driver class methods to connect the trip data to the driver data' do
        driver1 = Driver.new('Dan')
        driver2 = Driver.new('Bill')
        trip1 = Trip.new('Dan','07:15','07:45','17.3')
        trip2 = Trip.new('Bill','01:05','03:32','31.0')
        trip3 = Trip.new('Dan','013:47','16:07','67.5')

        driver_list = [driver1,driver2]
        trip_list = [trip1,trip2,trip3]

        trip_addition(driver_list,trip_list)

        expect(driver1.trips.length()).to eq(2)
        expect(driver2.trips.length()).to eq(1)

    end
end

describe 'driver_sort' do
    it 'sorts the driver data be descending total distance driven' do
        driver1 = Driver.new('Dan')
        driver2 = Driver.new('Bill')
        driver3 = Driver.new('Sam')
        trip1 = Trip.new('Dan','07:15','07:45','17.3')
        trip2 = Trip.new('Bill','01:05','03:32','31.0')
        trip3 = Trip.new('Sam','013:47','16:07','67.5')

        driver_list = [driver1,driver2,driver3]
        trip_list = [trip1,trip2,trip3]

        trip_addition(driver_list,trip_list)

        driver_sort(driver_list)

        expect(driver_list[0].driver_name).to eq('Sam')
        expect(driver_list[1].driver_name).to eq('Bill')
        expect(driver_list[2].driver_name).to eq('Dan')

    end

    it 'sorts the driver data alphabetically when distance is tied' do
        driver1 = Driver.new('Dan')
        driver2 = Driver.new('Bill')
        driver3 = Driver.new('Sam')
        trip1 = Trip.new('Dan','07:15','07:45','17.3')
        trip2 = Trip.new('Bill','01:05','03:32','31.0')
        trip3 = Trip.new('Sam','013:47','16:07','31.0')

        driver_list = [driver1,driver2,driver3]
        trip_list = [trip1,trip2,trip3]

        trip_addition(driver_list,trip_list)

        driver_sort(driver_list)

        expect(driver_list[0].driver_name).to eq('Bill')
        expect(driver_list[1].driver_name).to eq('Sam')
        expect(driver_list[2].driver_name).to eq('Dan')

    end
end