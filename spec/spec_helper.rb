# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

require 'webrat'
require 'webrat/core/matchers'
include Webrat::Methods
Webrat.configure do |config|
  config.mode = :rails
end

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
end

def setup(email: nil, password: nil)
  user = User.find_by_email(email)
  if user.nil?
    user = User.new(email: email, :password => password, :password_confirmation => password)
  end
  Import.delete_all
  user
end
