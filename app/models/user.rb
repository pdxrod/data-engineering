require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base

  acts_as_authentic do # Authlogic
  end

  mount_uploader :uploader, FileUploader # Carrierwave

  def calculate!
  end
end
