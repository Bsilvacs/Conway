class GameMastersController < ApplicationController
  def new
  end

  def step
    @game_master = GameMaster.new(game_master_params)
    @game_master.step
    respond_to do |format|
      format.js
    end
  end


  private

  def game_master_params
    params.require(:game_master).permit(:board)
  end
end
