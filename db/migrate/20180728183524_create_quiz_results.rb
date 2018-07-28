class CreateQuizResults < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_results do |t|
      t.integer :correct
      t.string :direction
      t.string :quiz_type
      t.json :errors

      t.references :list, index: true
      t.timestamps
    end
  end
end
