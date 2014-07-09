require 'pathname'
require './rules'
require './matrix'
require './grid'

APP_NAME  = 'Ruby Life'
FILE_NAME = ARGV.first

if FILE_NAME
    matrix_file = Pathname.new(FILE_NAME)
    raise 'File not found' unless matrix_file.exist? & matrix_file.file?

    grid = Grid.new(matrix_file)
    grid.start_draw
else
  system 'clear'
  puts "\n\tWelcome to #{APP_NAME}!"
  puts "\n\tUsage: `ruby rlife.rb $FILE_NAME.TXT`"
  puts "\tFor example: `ruby rlife.rb ./example/example.txt`"
  puts ""
  exit  
end
