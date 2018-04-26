class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers do |t|
      t.string :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
