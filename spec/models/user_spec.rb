require 'spec_helper'

describe User do

  let(:filepath) { File.join( Rails.root, "example_input.tab" ) }
  let(:user_email) { 'user@data-engineering.com' }
  let(:user_password) { 'foobar' }

  before do
    old_user = User.find_by_email(user_email)
    old_user.destroy! unless old_user.nil?
  end

  it "should upload a file" do
    u = User.new(email: user_email, :password => user_password, :password_confirmation => user_password)
    u.uploader = File.open(filepath)
    u.save!
    url = u.uploader.url
    expect( url ).to match(/\/uploads\/user\/uploader\/[0-9]+\/example_input.tab/)
    path = File.join( Rails.root, 'public', url )
    expect( u.uploader.current_path ).to eq( path )
    expect( u.uploader.identifier ).to eq( 'example_input.tab' )
  end
end
