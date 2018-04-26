class CreateTests < ActiveRecord::Migration[5.1]
  def change
    create_table :tests do |t|
      t.text :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
