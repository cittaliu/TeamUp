class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.boolean :is_private
      t.string :img
      t.integer :creator_id
      t.belongs_to :department

      t.timestamps
    end
  end
end
