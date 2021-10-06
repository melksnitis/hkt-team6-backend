class GroupsController < JSONAPI::ResourceController
  skip_before_action :verify_authenticity_token

  def index
    render json: StaticTeams.new.teams
  end

  def show
    team = StaticTeams.new.teams.select {|a| a[:id] == params["id"].to_i}.first
    return unless team

    client = Slack::Web::Client.new
    members = client.users_list.members
    new_team_members = []
    members.select {|a| team[:members].include?(a.real_name)}.each do |member|
      new_team_members << {name: member.real_name, image_url: member.profile.image_512}
    end
    team[:members] = new_team_members

    render json: team
  end
end
  