class AddUuidToMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :messages, :uuid, :string
  end
end
