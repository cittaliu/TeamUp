class AddProgressToObjectives < ActiveRecord::Migration[5.0]
  def change
    add_column :objectives, :progress, :integer
  end
end
