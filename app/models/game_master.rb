class GameMaster
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  require 'matrix'

  attr_accessor :board

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    if(self.board == nil)
      self.board = get_new_board
    end
  end

  #NOTE TO SELF: eval is NOT safe for inputs.
  def board=(attr)
    if attr.is_a?(String)
      @board = eval attr
    else
      @board = attr
    end
  end

  def persisted?
    false
  end

  def step
    self.board = evaluate_rules
  end

  private

  def get_new_board
    Matrix.build(20,20) { |row, col|  [0,0,0,0,0,1].sample}
  end

  def evaluate_rules
    #First, lets get the alive neighbors for each position
    newBoard = Matrix.zero(20)
    self.board.each_with_index do |value, row, col|
      aliveNeighbors = 0
      #Neighbor 1
      if row > 0
        if self.board.[](row-1, col) == 1
          aliveNeighbors += 1
        end
      end

      #Neighbor 2
      if row > 0
        if self.board.[](row-1, col+1) == 1
          aliveNeighbors += 1
        end
      end

      #Neighbor 3
      if self.board.[](row, col+1) == 1
        aliveNeighbors += 1
      end

      #Neighbor 4
      if self.board.[](row+1, col+1) == 1
        aliveNeighbors += 1
      end

      #Neighbor 5
      if self.board.[](row+1, col) == 1
        aliveNeighbors += 1
      end

      #Neighbor 6
      if col > 0
        if self.board.[](row+1, col-1) == 1
          aliveNeighbors += 1
        end
      end

      #Neighbor 7
      if col > 0
        if self.board.[](row, col-1) == 1
          aliveNeighbors += 1
        end
      end

      #Neighbor 8
      if row > 0 && col > 0
        if self.board.[](row-1, col-1) == 1
          aliveNeighbors += 1
        end
      end
      #Now that we have the neighbors, we can evaluate the rules
      case
        when aliveNeighbors < 2 && self.board.[](row,col) == 1
          newCell = 0
        when (aliveNeighbors == 2 || aliveNeighbors == 3) && self.board.[](row,col) == 1
          newCell = 1
        when aliveNeighbors > 3 && self.board.[](row,col) == 1
          newCell = 0
        when aliveNeighbors == 3 && self.board.[](row,col) == 0
          newCell = 1
        else
          newCell = self.board.[](row,col)
      end
      #Building the new board
      newBoard.send(:[]=,row,col,newCell)
    end
    newBoard
  end
end