SIGN_OF_DEATH = '0'
LIFE_SYM = '*'
DEAD_SYM = ' '

class Grid
  attr_reader :living, :matrix
  def initialize( file = nil )
    @matrix = Matrix.new(file)
    @living = living_coords(matrix.data)
  end

  def living_coords data
    coords = []
    data.each_with_index {|line, y|
      line.chars.each_with_index {|char, x|
        coords << [x, y] if char != SIGN_OF_DEATH
      }
    }
    coords
  end

  def neighbors_coords *coords
    x, y  = coords
    xsize = @matrix.size[0] - 1
    ysize = @matrix.size[1] - 1
    arr   = []
    (-1..1).each { |i|
      yi = y + i
      (-1..1).each { |k|
        xk = x + k
        if (0..xsize).include?(xk) & (0..ysize).include?(yi)
          arr << [x + k, y + i] if ([xk, yi] != [x, y])
        end
      }
    }
    arr
  end

  def cells_staying_alive
    @living.select { |coord| Rules.still_alive?(living_count_around(*coord)) }
  end

  def cells_becoming_alive
    dead = []
    @living.each { |coord| dead += living_dead_around(*coord) }
    dead.uniq.select { |coord|
      Rules.becomes_alive?(living_count_around(*coord))
    }
  end

  def living_count_around *coords
    (@living & neighbors_coords(*coords)).count
  end

  def living_dead_around *coords
    neighbors_coords(*coords) - @living
  end

  def next_living
    cells_staying_alive + cells_becoming_alive
  end

  def live_stagnate?(living, next_living)
    living == next_living
  end

  def life_not_found
    living.count == 0
  end

  def draw data
    arr = []
    (0..@matrix.size[1] - 1).each { |y|
      s = ''
      (0..@matrix.size[0] - 1).each { |x|
        (data).include?([x, y]) ? s += LIFE_SYM : s += DEAD_SYM
      }
      arr << s
    }
    arr.each { |str| puts "\t#{str}" }
  end

  def start_draw
    step = 1

    begin
      @living = next_living if step > 1

      system 'clear'
      puts "\n\tStep ##{step}. Lives count: #{@living.count}"
      puts "\t#{'-' * @matrix.size[0]}"
      draw( @living )
      puts "\t#{'-' * @matrix.size[0]}"

      if life_not_found
        puts "\n\tLife not found"
      elsif live_stagnate?(@living, next_living)
        puts "\tStagnation"
      end

      puts ""    

      sleep(1)

      step += 1
    end until life_not_found or live_stagnate?(@living, next_living)
  end
end