require 'spec_helper'

describe UploadsController do
  render_views

  it "show action should render upload template" do
    get :upload
    response.should render_template(:upload)
  end
end
