require 'spec_helper'

describe User do

  let(:filepath) { File.join( Rails.root, "example_input.tab" ) }

  it "should upload a file" do
    u = User.new(email: 'user@data-engineering.com', :password => 'foobar', :password_confirmation => 'foobar')
    u.uploader = File.open(filepath)
    u.save!
    u.uploader.url # => '/url/to/file.png'
    u.uploader.current_path # => 'path/to/file.png'
    u.uploader.identifier # => 'file.png'

  end
end
