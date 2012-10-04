class AddEmailToEntry < ActiveRecord::Migration
  def change
    add_column :entries, :email, :string
  end
end
