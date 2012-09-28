class AddReferralKeyToUser < ActiveRecord::Migration
  def change
    add_column :users, :referral_key, :integer
  end
end
