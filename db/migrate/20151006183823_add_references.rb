class AddReferences < ActiveRecord::Migration
  def change
    add_reference :competitions, :users, index: true
    add_reference :competitors, :competitions, index: true
  end
end
