#!/usr/bin/env ruby

require './MongoGribParser.rb'

gp = MongoGribParser.new('sst.csv')
gp.exec
