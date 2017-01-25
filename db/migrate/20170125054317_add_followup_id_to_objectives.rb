class AddFollowupIdToObjectives < ActiveRecord::Migration[5.0]
  def change
    add_column :objectives, :follow_id, :integer, array: true, default: []
  end
end
