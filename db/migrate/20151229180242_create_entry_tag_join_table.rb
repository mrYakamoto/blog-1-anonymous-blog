class CreateEntryTagJoinTable < ActiveRecord::Migration
  def change
    create_table :entries_tags, :id => false do |t|
      t.references :entry
      t.references :tag
  end
end
