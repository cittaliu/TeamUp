class CreateObjectives < ActiveRecord::Migration[5.0]
  def change
    create_table :objectives do |t|
      t.string :title
      t.text :description
      t.string :status
      t.belongs_to :user
      t.belongs_to :team
      t.belongs_to :department
      
      t.timestamps
    end
  end
end
