require 'spec_helper'

describe UploadsController do

  before do
    setup(email: 'user@data-engineering.com', password: 'foobar')
  end

  it "should go straignt to the uploads page" do
    visit '/'
    expect( response.body ).to match( /find a file and upload it/mi )
  end

  it "should successfully upload a file" do

  end

end
