Conway::Application.routes.draw do
  post "game_masters/step"
  post "home/new"
  root "home#new"
end
