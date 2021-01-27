require "./models/trip"

describe 'Trip' do
    describe '.length_hours' do
        it 'calculates the length of a trip in hours' do
            trip = Trip.new('Dan','06:00','06:30','20.1')
            
            expect(trip.length_hours).to be_within(0.001).of(0.5)
        
        end
    end
    
    describe '.speed' do
        it 'calculates the speed in mph of a trip' do
            trip = Trip.new('Dan','06:00','06:30','20.1')
            
            expect(trip.speed).to be_within(0.001).of(40.2)
        
        end
    
    end
    
    describe '.speed_check' do
        it 'returns false for trips with speed below 5 mph' do
            trip = Trip.new('Dan','06:00','07:00','4.99')
            
            expect(trip.speed_check).to be false
        
        end
        
        it 'returns false for trips with speed above 100 mph' do
            trip = Trip.new('Dan','06:00','7:00','100.01')
            
            expect(trip.speed_check).to be false
        
        end
        
        it 'returns true for trips with speed between 5 and 100 mph' do
            trip1 = Trip.new('Dan','06:00','07:00','20.1')
            trip2 = Trip.new('Dan','06:00','07:00','5.0')
            trip3 = Trip.new('Dan','06:00','07:00','100.0')
            
            expect(trip1.speed_check).to be true
			expect(trip2.speed_check).to be true
            expect(trip3.speed_check).to be true
        end
    end
end