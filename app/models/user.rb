class User < ActiveRecord::Base
  attr_accessor :referral
  attr_accessible :email, :first_name, :last_name, :referral_key, :referral
  
  has_many :entries, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email.downcase! }

  validates :first_name,
  :presence => { :message => " Please enter first name" },
  length: { maximum: 50, :message => "First name cant be over 50 characters" }
  validates :last_name,
  :presence => { :message => " Please enter last name" },
  length: { maximum: 50, :message => "Last name cant be over 50 characters" }

  validates :email,
  :presence => { :message => "Please enter email" },
  format: { with: VALID_EMAIL_REGEX, :message => "Must be valid email." }
  validate :validate_only_one_signup_per_week
  
  validate :validate_referral_existence
  
  validate :validate_referral_ownership

  scope :in_the_past_week, lambda { where('created_at > ?', 1.week.ago) }
  
  def validate_referral_existence
    if !referral.blank? and !User.exists?(:referral_key => referral)
      self.errors.add(:referral, 'Invalid referral key.')
    end
  end
  
  def validate_referral_ownership
    if !referral.blank? and referral == referral_key.to_s
      self.errors.add(:referral, 'You cannot refer yourself.')
    end
  end

  def validate_only_one_signup_per_week
    if User.where(:email => self.email).in_the_past_week.any?
      self.errors.add(:email, 'can only one be entered once per week')
    end
  end
  
  def create_entries(referralKey)
    entry = Entry.new
    entry.user_id = self.referral_key
    entry.save
    if !referralKey.blank? # User.exists?(referral_key: referralKey)
      refEntry = Entry.new
      refEntry.user_id = referralKey
      refEntry.save
    end
  end

end

# validates :email, uniqueness: { scope: lambda { User.find_by_email(email).in_the_past_week.any? } }
# scope :in_the_past_week, lambda { where(['created_at > ?', 1.week.ago] }
#  
#  if User.find_by_email(email).in_the_past_week.any?
#    puts "you can only sign up once a week"
#  end
#   User.find_by_email(email).in_the_past_week.any?
#   scope :in_the_past_week, lambda { where(['created_at > ?', 1.week.ago] }
# 
# def validate_only_one_signup_this_week; 
#   
#   end
# :validate_only_one_signup_this_week, :on => :create
# :scope => lambda { where(":created_at < ?", Time.1.week.ago) }


# def validate_only_one_signup_per_week
#   if self.class.find_by_email(self.email).in_the_past_week.any?
#     self.errors.add([:email, 'can only one be entered once per week'])
#   end
# end
# 
# scope :in_the_past_week, lambda { where(['created_at > ?', 1.week.ago]) }

# validates :check1, acceptance: true
# validates :check2, acceptance: true

# validates_acceptance_of :check1, :allow_nil => false, :message => "Checkbox 1 must be checked."
# validates_acceptance_of :check2, :accept => true,  :message => "Checkbox 2 must be checked."



