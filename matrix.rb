class Matrix
  attr_reader :data, :size
  def initialize( file = nil )
    @data = get_data_from_file(file)
    @size = [ data[0].size, data.size ]
  end

  protected
  def get_data_from_file file
    data_arr = []
    file.open('r').each { |line| data_arr << line.chomp }
    data_arr
  end
end