class RemoveErrorsJsonFromQuizResults < ActiveRecord::Migration[5.2]
  def change
    remove_column :quiz_results, :errors
  end
end
