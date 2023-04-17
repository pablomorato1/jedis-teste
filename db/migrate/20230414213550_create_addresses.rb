class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.string :cep, null: false
      t.string :street, null: false
      t.string :complement, null: false
      t.string :neighborhood, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.string :ibge
      t.timestamps
    end
  end
end
