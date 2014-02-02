require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base

  acts_as_authentic do # Authlogic
  end

  mount_uploader :uploader, FileUploader # Carrierwave

  def calculate!

    url = File.join( Rails.root, 'public', uploader.url )
    contents = File.read( url )

    contents.each_line do |line|
      next if line.strip == ''
      data = line.split( "\t" )
      data.map( &:chomp! )
      import = Import.new(purchaser_name: data[0], item_description: data[1],	item_price: data[2],
                          purchase_count: data[3], merchant_address: data[4],	merchant_name: data[5])
      import.save!
    end

  end

end
