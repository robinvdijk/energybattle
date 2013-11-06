class ChangeBattles < ActiveRecord::Migration
  def change
    add_column :battles, :title, :string
    add_column :battles, :start_date, :datetime
    add_column :battles, :end_date, :datetime
    add_column :battles, :game_type, :string
    add_column :battles, :player_limit, :integer
    add_column :battles, :access, :boolean
    add_column :battles, :duration, :integer
  end
end
