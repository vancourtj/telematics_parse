# How to run

## script

Set your directory to the main project folder ```telematics_parse```, make sure the input data file ```input.txt``` is in ```/lib```, and run in command line:

```cat lib/input.txt | lib/main.rb```

## tests

Set your directory to the main project folder and run in command line:

```bundle exec rspec```

# Problem statement and background

This ruby project takes formatted telematics data from a text file, parses it, and outputs a data summary in a text file.

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

The output file will be put into the parent folder, not ```lib```

# Design Choices

## ```Main```

I wanted the main file to be responsible for as little as possible. In this case, file input and calling the main service. This allowed me to split out ```services``` and ```models``` and split their respective spec files as well. This segmentation of the code felt the most natural.

## ```Models```

There's an obvious one driver to many trips relationship in the data and there are manipulations that one wants to do at the trip level and the driver level. This led me to creating ```Driver``` and ```Trip``` classes. The ```Driver.add_trip``` method adds allowed trips to a driver (match on driver name, trip speed allowed). The array of trips can then be aggregated as needed for each driver with various driver class methods.

This type of data model is similar to the injury evaluation model in claims where many evaluation line items are tied to one involved party and wrap up to a single severity variable at the party level.

## ```Services```
This is split into more script like ```functions``` and a text line class ```TextParse```

The functions here:
- initialize the found driver and trip class instances
- call the ```add_trip``` method for each driver
- sort the drivers by their distance and name*
- write to the output file

```TextParse``` models the base commonalities of each line of text, a command type and related data.

\* I chose to add the alphabet sort on distance tie because I wanted to put a little more structure on the output
 
