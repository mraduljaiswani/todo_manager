class CreateCars < ActiveRecord::Migration[6.1]
  def change
    create_table :cars do |t|
      t.text :todo_text
      t.date :due_date
      t.boolean :completed

      t.timestamps
    end
  end
end
