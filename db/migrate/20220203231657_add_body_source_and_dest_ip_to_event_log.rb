class AddBodySourceAndDestIpToEventLog < ActiveRecord::Migration[7.0]
  def change
    add_column :event_logs, :source_ip, :string
    add_column :event_logs, :dest_ip, :string
    add_column :event_logs, :body, :text
  end
end
