class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :title
      t.string :subject
      t.string :topic1
      t.string :topic2
      
      t.timestamps
    end
  end
end
