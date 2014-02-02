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
    Import.delete_all
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

  it "should save the contents of the file in the database and calculate the total" do
    expect( Import.count ).to eq(0)
    @user.uploader = File.open(file_path)
    @user.save!
    @user.calculate!
    expect( Import.count ).to eq(4)

    row = Import.last
    expect( row.purchaser_name ).to eq("Snake Plissken")
    expect( row.item_description ).to eq("$20 Sneakers for $5")
    expect( row.item_price ).to eq(5.0)
    expect( row.purchase_count ).to eq(4)
    expect( row.merchant_address ).to eq("123 Fake St")
    expect( row.merchant_name ).to eq("Sneaker Store Emporium")

    expect( User.total_amount_gross_revenue ).to eq( 95.0 )

  end
end
