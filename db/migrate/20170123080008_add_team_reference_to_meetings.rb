class AddTeamReferenceToMeetings < ActiveRecord::Migration[5.0]
  def change
    add_reference :meetings, :team, foreign_key: true
  end
end
