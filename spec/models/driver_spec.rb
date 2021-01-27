require "./models/driver"
require "./models/trip"

describe 'Driver' do
	
	it 'should have no trips until a trip is added' do
		
		driver = Driver.new('Dan')
		
		expect(driver.trips).to match_array([])
	
	end
	
	describe '.add_trip' do
		
		it 'adds a new trip to the list of trips for the Driver class' do
			
			driver = Driver.new('Dan')
			trip = Trip.new('Dan','07:15','07:45','17.3')
			driver.add_trip(trip)
			
			expect(driver.trips.length()).to eq(1)
		
		end
		
		it 'only adds trips for the specific driver' do
			
			driver = Driver.new('Dan')
			trip1 = Trip.new('Dan','07:15','07:45','17.3')
			trip2 = Trip.new('Bill','07:15','07:45','17.3')
			
			driver.add_trip(trip1)
			driver.add_trip(trip2)
			
			expect(driver.trips.length()).to eq(1)
		
		end
		
		it 'only adds trips that are within the expected speed range' do
			
			driver = Driver.new('Dan')
			trip1 = Trip.new('Dan','07:15','07:45','17.3')
			trip2 = Trip.new('Dan','07:00','08:00','100.01') #above 100
			trip3 = Trip.new('Dan','07:00','08:00','4.99') #below 5
			
			driver.add_trip(trip1)
			driver.add_trip(trip2)
			driver.add_trip(trip3)
			
			expect(driver.trips.length()).to eq(1)
		
		end	
	end
	
	describe '.total_distance' do
		
		it 'returns 0 when there are no trips' do
			
			driver = Driver.new('Dan')
			
			expect(driver.total_distance).to eq(0)
		
		end
		
		it 'calculates the total distance traveled across all trips for a driver' do
			
			driver = Driver.new('Dan')
			trip1 = Trip.new('Dan','07:15','07:45','17.3')
			trip2 = Trip.new('Dan','06:00','06:30','20.1')
			
			driver.add_trip(trip1)
			driver.add_trip(trip2)
			
			expect(driver.total_distance).to be_within(0.001).of(37.4)
		
		end
	end
	
	describe '.total_length_hours' do
		
		it 'returns 0 when there are no trips' do
			
			driver = Driver.new('Dan')
			
			expect(driver.total_length_hours).to eq(0)
		
		end
		
		it 'calculates the total hours driven across all trips for a driver' do
			
			driver = Driver.new('Dan')
			trip1 = Trip.new('Dan','07:15','07:45','17.3')
			trip2 = Trip.new('Dan','06:00','06:30','20.1')
			
			driver.add_trip(trip1)
			driver.add_trip(trip2)
			
			expect(driver.total_length_hours).to be_within(0.001).of(1.0)
		
		end
	end
	
	describe '.avg_speed' do
		
		it 'returns nil when there are no trips' do
			
			driver = Driver.new('Dan')
			
			expect(driver.avg_speed).to be_nil
		
		end
		
		it 'returns nil when total length hours is 0' do
			
			driver = Driver.new('Dan')
			trip = Trip.new('Dan','07:15','07:15','17.3')
			
			driver.add_trip(trip)
			
			expect(driver.avg_speed).to be_nil
		
		end
		
		it 'calculates the avg speed across all trips for a driver' do
			
			driver = Driver.new('Dan')
			trip1 = Trip.new('Dan','07:15','07:45','17.3')
			trip2 = Trip.new('Dan','06:00','06:30','20.1')
			
			driver.add_trip(trip1)
			driver.add_trip(trip2)
			
			expect(driver.avg_speed).to be_within(0.001).of(37.4)
		
		end
	end
end