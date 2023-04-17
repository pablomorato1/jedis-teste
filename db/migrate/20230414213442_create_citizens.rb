class CreateCitizens < ActiveRecord::Migration[7.0]
  def change
    create_table :citizens do |t|
      t.string :full_name, null: false
      t.string :cpf, null: false
      t.string :cns, null: false
      t.string :email, null: false
      t.string :birth_date, null: false
      t.string :phone_number, null: false
      t.boolean :active, default: true
      t.timestamps
    end

    add_index :citizens, :cpf,                unique: true
    add_index :citizens, :cns,                unique: true
    add_index :citizens, :email,                unique: true
  end
end
