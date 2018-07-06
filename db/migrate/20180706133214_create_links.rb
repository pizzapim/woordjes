class CreateLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :links do |t|
      t.string :word1
      t.string :word2

      t.timestamps
    end
  end
end
