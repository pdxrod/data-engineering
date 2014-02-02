require 'spec_helper'

describe UploadsController do

  it "should go straignt to the uploads page" do
    visit '/'
    expect( response.body ).to match( /enter a filename/mi )

  end

end
