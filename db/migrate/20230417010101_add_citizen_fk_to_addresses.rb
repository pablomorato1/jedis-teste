class AddCitizenFkToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :citizen, null: false, foreign_key: true
  end
end
