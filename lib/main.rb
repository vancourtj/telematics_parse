#!/usr/bin/env ruby

#link the required methods
require_relative 'methods'
require_relative 'models'

#read in the data file from command line
input_data = ARGF.read
ARGF.close

#call the full parsing function
full_data_parse(input_data)