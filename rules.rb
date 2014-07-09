TO_LIFE_COUNT_NEIGHBORS = 3
NEIGHBORS_FOR_LIFE      = [2, 3]

class Rules
  def self.still_alive? alive_neighbors
    NEIGHBORS_FOR_LIFE.include?( alive_neighbors )
  end

  def self.becomes_alive? alive_neighbors
    alive_neighbors == TO_LIFE_COUNT_NEIGHBORS
  end
end