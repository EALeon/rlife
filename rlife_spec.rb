require './rules'
require './grid'

describe Rules, 'still_alive?' do
  it 'should be true' do
    (2..3).each { |e| Rules.still_alive?(e).should be_true }
  end

  it 'should be false' do
    (0..10).each { |e|
      Rules.still_alive?(e).should be_false unless [2,3].include?(e)
    }
  end
end

describe Rules, 'becomes_alive?' do
  it 'should be true' do
    Rules.becomes_alive?(3).should be_true
  end

  it 'should be false' do
    (0..9).each { |e| Rules.becomes_alive?(e).should be_false if e != 3 }
  end
end
