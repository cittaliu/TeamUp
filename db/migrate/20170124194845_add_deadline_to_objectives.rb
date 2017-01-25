class AddDeadlineToObjectives < ActiveRecord::Migration[5.0]
  def change
    add_column :objectives, :deadline, :datetime
  end
end
