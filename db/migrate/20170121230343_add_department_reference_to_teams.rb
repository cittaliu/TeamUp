class AddDepartmentReferenceToTeams < ActiveRecord::Migration[5.0]
  def change
    add_reference :teams, :department, foreign_key: true
  end
end
