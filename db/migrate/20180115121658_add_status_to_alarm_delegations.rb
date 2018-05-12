class AddStatusToAlarmDelegations < ActiveRecord::Migration[5.1]
  def change
    add_column :alarm_delegations, :status, :string, default: 'open'
  end
end
