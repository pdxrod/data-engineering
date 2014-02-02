class User < ActiveRecord::Base
  mount_uploader :uploader, FileUploader
end
