# telematics_parse

This ruby project takes a formatted text file, parses it, and outputs a data summary. The data happens to be telematics related.

The output file is each driver's total distance and average speed.

The input file is expected to be in ``` lib ``` and you'll need to run the script in the command line \
``` cat lib/input.txt | lib/main.rb ```

The test cases can be run with \
``` rspec ./spec/methods_spec.rb ```

And

``` rspec ./spec/models_spec.rb ```
