require 'spec_helper'

describe User do

  let(:file_path) { File.join( Rails.root, "example_input.tab" ) }
  let(:user_email) { 'user@data-engineering.com' }
  let(:user_password) { 'foobar' }
  @user = nil

  before do
    @user = User.find_by_email(user_email)
    if @user.nil?
      @user = User.new(email: user_email, :password => user_password, :password_confirmation => user_password)
    end
  end

  it "should upload a file" do
    @user.uploader = File.open(file_path)
    @user.save!
    url = @user.uploader.url
    expect( url ).to match(/\/uploads\/user\/uploader\/[0-9]+\/example_input.tab/)
    path = File.join( Rails.root, 'public', url )
    expect( @user.uploader.current_path ).to eq( path )
    expect( @user.uploader.identifier ).to eq( 'example_input.tab' )
  end

  it "should save the contents of the file in the database" do
    @user.uploader = File.open(file_path)
    @user.save!
    @user.calculate!


  end
end
