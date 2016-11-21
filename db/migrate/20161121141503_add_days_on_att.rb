class AddDaysOnAtt < ActiveRecord::Migration[5.0]
  def change
  	add_column :parking_places, :days, :text
  end
end
