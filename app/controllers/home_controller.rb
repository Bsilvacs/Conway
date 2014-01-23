class HomeController < ApplicationController
  def new
    @game_master = GameMaster.new
  end

end
