class Entry < ActiveRecord::Base
  attr_accessible :user_id, :referred
  
  belongs_to :user, primary_key: :referral_key
  
  scope :in_the_past_week, lambda { where('created_at > ?', 1.week.ago) }
end
