class CreatePups < ActiveRecord::Migration[5.0]
  def change
    create_table :pups do |t|
      t.string :title
      t.string :description
      t.string :img
      t.string :url

      t.timestamps
    end
  end
end
