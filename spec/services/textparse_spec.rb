require "./services/textparse"

describe 'TextParse' do
    describe 'parse' do
        it 'returns an array of a space delimited line of text' do
            line = TextParse.new('Driver Dan')

            expect(line.parse[0]).to eq('Driver')
            expect(line.parse[1]).to eq('Dan')

        end
    end

    describe 'type' do
        it 'returns the first element of a parsed line' do
            line1 = TextParse.new('Driver Dan')
            line2 = TextParse.new('Trip Dan 07:15 07:45 17.3')

            expect(line1.type).to eq('Driver')
            expect(line2.type).to eq('Trip')

        end
    end

    describe 'data' do
        it 'returns nothing when the type is not driver or trip' do
            line = TextParse.new('Nope Dan')
            
            expect(line.data).to be_nil

        end

        it 'returns the driver name for a trip' do
            line = TextParse.new('Driver Dan')

            expect(line.data).to eq('Dan')

        end

        it 'returns an array of trip data for trips' do
            line = TextParse.new('Trip Dan 07:15 07:45 17.3')

            expect(line.data).to eq(['Dan','07:15','07:45',17.3])

        end
    end
end