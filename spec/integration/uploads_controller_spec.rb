require 'spec_helper'

describe UploadsController do

  before do
    setup(email: 'user@data-engineering.com', password: 'foobar')
  end

  it "should go straignt to the uploads page" do
    visit '/'
    expect( response.body ).to match( /Find a file by clicking on 'Browse', then hit 'Save'/m )
  end

end
