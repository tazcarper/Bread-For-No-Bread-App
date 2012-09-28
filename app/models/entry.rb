class Entry < ActiveRecord::Base
  attr_accessible :user_id
  
  belongs_to :user, primary_key: :referral_key
end
