class AddReferredToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :referred, :boolean, default: false
  end
end
