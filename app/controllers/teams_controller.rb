class TeamsController < ApplicationController
  def index
    teams = [
      { name: 'Diego Marczal' },
      { name: 'Alex Sandro De Castilho' },
      { name: 'Isabela Taques Vitek' },
      { name: 'Amanda Carolyne de Lima' },
      { name: 'Denis Lucas Silva' }
    ]

    render json: teams
  end
end
