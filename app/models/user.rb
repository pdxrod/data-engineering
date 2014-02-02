require 'carrierwave/orm/activerecord'

class User < ActiveRecord::Base

  acts_as_authentic do # Authlogic
  end

  mount_uploader :uploader, FileUploader # Carrierwave

  def import!(contents: nil)
    if contents.nil?
      url = File.join( Rails.root, 'public', uploader.url )
      contents = File.read( url )
    end

    contents.each_line.with_index do |line, index|
      next if index == 0
      next if line.strip == ''
      data = line.split( "\t" )
      data.map( &:chomp! )
      import = Import.new(purchaser_name: data[0], item_description: data[1],	item_price: data[2],
                          purchase_count: data[3], merchant_address: data[4],	merchant_name: data[5])
      import.save!
    end
  end

  def User.total_amount_gross_revenue
    return nil if Import.count < 1
    total = 0.0
    Import.all.each { |row| total += row.item_price * row.purchase_count }
    total
  end

end
