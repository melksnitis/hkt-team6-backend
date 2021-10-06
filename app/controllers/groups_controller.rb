class GroupsController < JSONAPI::ResourceController
  skip_before_action :verify_authenticity_token

  def index
    render json: StaticTeams.new.teams
  end

  def show
    
  end
end
  