class GroupsController < JSONAPI::ResourceController
  skip_before_action :verify_authenticity_token

  def index
    teams = StaticTeams.new.teams
    teams.each do |team|
      new_team_members = []
      client = Slack::Web::Client.new
      members = client.users_list.members
      new_team_members = []
      members.select {|a| team[:members].include?(a.real_name)}.each do |member|
        new_team_members << {name: member.real_name, image_url: member.profile.image_512}
      end
      team[:members] = new_team_members
    end 

    render json: teams
  end
end
  