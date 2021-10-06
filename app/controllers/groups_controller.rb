class GroupsController < JSONAPI::ResourceController
  skip_before_action :verify_authenticity_token

  def index
    file = File.read(File.join(Rails.root, 'app', 'json', 'groups.json'))
    json = JSON.parse(file)

    render json: json
  end

  def show
    
  end
end
  