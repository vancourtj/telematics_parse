# telematics_parse

This ruby project takes a formatted text file, parses it, and outputs a data summary in a text file. The data happens to be telematics related.

The incoming data is structured as space delimited lines of text where the first word represents a command and the subsequent words are data related to the command. The two commands are ```Driver``` and ```Trip```.

A ```Driver``` will have one piece of data, the driver name: ```Driver Person```

A ```Trip``` will have a driver name, a trip start time, trip end time, and distance traveled: ```Trip Person 00:05 01:05 21.1```
Trips with a speed less than 5 mph or greater than 100 mph are ignored.

The output file is each driver's total distance and average speed, both rounded to the nearest integer. The output will be sorted by distance descending and driver name alphabetically when distance is tied. For example:

```
Billy: 55 miles @ 35 mph
Bob: 55 miles @ 67 mph
Sam: 20 miles @ 15 mph
```


The input file is expected to be in ``` lib ``` and you'll need to run the script in the command line \
``` cat lib/input.txt | lib/main.rb ```

The test cases can be run with \
``` rspec ./spec/methods_spec.rb ``` Or ``` rspec ./spec/driver_model_spec.rb ``` Or ```rspec ./spec/trip_model_spec.rb```

The output file will be put into the parent folder, not ```lib```

# Design Choices

## ```Main```

I wanted the main file to be responsible for as little as possible. In this case, file input and calling the main method. This allowed me to split out the functions into ```methods.rb``` and the classes into ```models.rb``` and split their respective spec files as well. This segmentation of the code felt the most natural.

## ```Models```

There's an obvious one driver to many trips relationship in the data and there manipulations that one wants to do at the trip level and the driver level. This led me to creating ```Driver``` and ```Trip``` classes. The ```Driver.add_trip``` method adds allowed trips to be added to a driver attribute (match on driver name, trip speed allowed). The array of trips can then be aggregated as needed for each driver with various driver class methods.

This type of data model is similar to the injury evaluation model in claims where many evaluation line items are tied to one involved party and wrap up to a single severity variable at the party level.

## ```Methods```
The methods here are meant to deal with the operations needed outside the base driver-trip model. These methods:
- split and parse the input data
- initialize the found driver and trip class instances
- call the ```add_trip``` method for each driver
- sort the drivers by their distance and name*
- format the driver data into the expected output
- write to the output file

\* I chose to add the alphabet sort on distance tie because I wanted to put a little more structure on the output
 
