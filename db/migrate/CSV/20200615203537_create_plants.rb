class CreatePlants < ActiveRecord::Migration[6.0]
  def change
    create_table :plants do |t|
      t.date :germination_date
      t.date :transplant_date
      t.string :nickname
      t.string :variety
      t.string :species
      t.text :description
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :bed, index: true, foreign_key: true

      t.timestamps
    end
  end
end
