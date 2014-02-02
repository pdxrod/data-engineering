class PopulateUsers < ActiveRecord::Migration
  def change
    user = User.find_by_email('user@data-engineering.com')
    if user.nil?
      user = User.new(email: 'user@data-engineering.com', :password => 'foobar', :password_confirmation => 'foobar')
      user.save!
    end
  end
end
