class AddHarvestedToPlants < ActiveRecord::Migration[6.0]
  def change
    add_column :plants, :harvested, :boolean, null: false, default: false
  end
end
