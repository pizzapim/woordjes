class CreateQuizErrors < ActiveRecord::Migration[5.2]
  def change
    create_table :quiz_errors do |t|
      t.string :word1
      t.string :word2
      t.string :answer
      
      t.references :quiz_result, index: true
    end
  end
end
