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
``` rspec ./spec/methods_spec.rb ```

And

``` rspec ./spec/models_spec.rb ```

The output file will be put into the parent folder, not ```lib```
