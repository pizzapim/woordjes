class CreateReferencesForListsAndLinks < ActiveRecord::Migration[5.2]
  def change
    add_reference :links, :list, index: true
    add_reference :lists, :user, index: true
  end
end
