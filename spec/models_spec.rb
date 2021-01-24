require "models"

describe 'Driver' do
	it 'should have no trips until a trip is added' do
		d1 = Driver.new('Dan')
		expect(d1.trips).to match_array([])
	end
	describe '.add_trip' do
		it 'adds a new trip to the list of trips for the Driver class' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:45','17.3')
			d1.add_trip(t1)
			expect(d1.trips.length()).to eq(1)
		end
		it 'only adds trips for the specific driver' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:45','17.3')
			t2 = Trip.new('Bill','07:15','07:45','17.3')
			d1.add_trip(t1)
			d1.add_trip(t2)
			expect(d1.trips.length()).to eq(1)
		end
		it 'only adds trips that are within the expected speed range' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:45','17.3')
			t2 = Trip.new('Dan','07:00','08:00','100.01') #above 100
			t3 = Trip.new('Dan','07:00','08:00','4.99') #below 5
			d1.add_trip(t1)
			d1.add_trip(t2)
			d1.add_trip(t3)
			expect(d1.trips.length()).to eq(1)
		end
	end
	describe '.total_distance' do
		it 'returns 0 when there are no trips' do
			d1 = Driver.new('Dan')
			expect(d1.total_distance).to eq(0)
		end
		it 'calculates the total distance traveled across all trips for a driver' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:45','17.3')
			t2 = Trip.new('Dan','06:00','06:30','20.1')
			d1.add_trip(t1)
			d1.add_trip(t2)
			expect(d1.total_distance).to be_within(0.001).of(37.4)
		end
	end
	describe '.total_length_hours' do
		it 'returns 0 when there are no trips' do
			d1 = Driver.new('Dan')
			expect(d1.total_length_hours).to eq(0)
		end
		it 'calculates the total hours driven across all trips for a driver' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:45','17.3')
			t2 = Trip.new('Dan','06:00','06:30','20.1')
			d1.add_trip(t1)
			d1.add_trip(t2)
			expect(d1.total_length_hours).to be_within(0.001).of(1.0)
		end
	end
	describe '.avg_speed'do
		it 'returns nil when there are no trips' do
			d1 = Driver.new('Dan')
			expect(d1.avg_speed).to be_nil
		end
		it 'returns nil when total length hours is 0' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:15','17.3')
			d1.add_trip(t1)
			expect(d1.avg_speed).to be_nil
		end
		it 'calculates the avg speed across all trips for a driver' do
			d1 = Driver.new('Dan')
			t1 = Trip.new('Dan','07:15','07:45','17.3')
			t2 = Trip.new('Dan','06:00','06:30','20.1')
			d1.add_trip(t1)
			d1.add_trip(t2)
			expect(d1.avg_speed).to be_within(0.001).of(37.4)
		end
	end
end

describe 'Trip' do
	describe '.length_hours' do
		it 'calculates the length of a trip in hours' do
			t1 = Trip.new('Dan','06:00','06:30','20.1')
			expect(t1.length_hours).to be_within(0.001).of(0.5)
		end
	end
	describe '.speed' do
		it 'calculates the speed in mph of a trip' do
			t1 = Trip.new('Dan','06:00','06:30','20.1')
			expect(t1.speed).to be_within(0.001).of(40.2)
		end
	end
	describe '.speed_check' do
		it 'returns false for trips with speed below 5 mph' do
			t1 = Trip.new('Dan','06:00','07:00','4.99')
			expect(t1.speed_check).to be false
		end
		it 'returns false for trips with speed above 100 mph' do
			t1 = Trip.new('Dan','06:00','7:00','100.01')
			expect(t1.speed_check).to be false
		end
		it 'returns true for trips with speed between 5 and 100 mph' do
			t1 = Trip.new('Dan','06:00','07:00','20.1')
			t2 = Trip.new('Dan','06:00','07:00','5.0')
			t3 = Trip.new('Dan','06:00','07:00','100.0')
			expect(t1.speed_check).to be true
			expect(t2.speed_check).to be true
			expect(t3.speed_check).to be true
		end
	end
end