class GameMaster
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  require 'matrix'

  attr_accessor :board

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
    self.board = get_new_board unless :board.nil?
  end

  DefaultBoard = [
      [0,0,0,0],
      [0,0,0,0],
      [0,0,0,0],
      [0,0,0,0]]

  def persisted?
    false
  end

  def step
    self.board = Matrix.build(4,4) { |row, col| rand (0..1)}
  end

  private

  def get_new_board
    Matrix.build(4,4) { |row, col| rand (0..1)}
  end

  def am_i_a_border?

  end

end