class GroupsController < JSONAPI::ResourceController
  skip_before_action :verify_authenticity_token
  require 'open-uri'

  def index
    teams = StaticTeams.new.teams
    teams.each do |team|
      new_team_members = []
      client = Slack::Web::Client.new
      members = client.users_list.members
      new_team_members = []

      members.select {|a| team[:members].include?(a.real_name)}.each do |member|
        puts member.real_name
        new_team_members << {name: member.real_name, image_url: "data:image/png;base64,#{Base64.encode64(URI.open(member.profile.image_32).read).gsub("\n", '')}"}
      end
      team[:members] = new_team_members
    end 

    render json: teams
  end
end
  