class AddPlanIdToSubscriptions < ActiveRecord::Migration
  def change
    add_column :subscriptions, :plan_id, :integer
    add_index :subscriptions, :plan_id
  end
end
