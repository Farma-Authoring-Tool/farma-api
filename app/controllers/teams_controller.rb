class TeamsController < ApplicationController
  def index
    teams = [
      { name: 'Diego Marczal' },
      { name: 'Alex Sandro De Castilho' },
      { name: 'Isabela Taques Vitek' }
      { name: 'Eleandro Maschio' }
    ]

    render json: teams
  end
end
