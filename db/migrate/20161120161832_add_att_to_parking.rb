class AddAttToParking < ActiveRecord::Migration[5.0]
  def change
  	add_column :parking_places, :class_name, :text
    add_column :parking_places, :subject, :string
    add_column :parking_places, :monthly_fee, :string
    add_column :parking_places, :yearly_fee, :string
  end
end
