class TuringMachine
  def initialize()
    @tape = []
    @cursor = 0
    @state = :a
  end

  def read
    @tape[@cursor] || 0
  end

  def write(value)
    @tape[@cursor] = value
  end

  def move_right
    @cursor+= 1
  end
  
  def move_left
    if @cursor > 0
      @cursor-= 1
    else
      @tape.unshift(0)
    end
  end

  def step
    @state = self.method(@state).call
  end
end
