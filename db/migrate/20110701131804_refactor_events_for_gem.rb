class RefactorEventsForGem < ActiveRecord::Migration
  def change
    add_column :events, :all_day, :boolean
  end
end
