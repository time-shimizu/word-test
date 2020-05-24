class ChangeHighestScoreOfUsers < ActiveRecord::Migration[5.2]
  def up
    change_column :users, :highest_score, :integer, default: 0
  end

  def down
    change_column :users, :highest_score, :integer
  end
end
