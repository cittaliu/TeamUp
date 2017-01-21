class AddTeamReferenceToObjectives < ActiveRecord::Migration[5.0]
  def change
    add_reference :objectives, :team, foreign_key: true
  end
end
