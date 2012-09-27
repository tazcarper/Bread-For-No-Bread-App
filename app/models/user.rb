class User < ActiveRecord::Base

 VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

 attr_accessible :email, :first_name, :last_name

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
 validate :validate_only_one_signup_per_week,
   :on => :create

 scope :in_the_past_week, lambda { where('created_at > ?', 1.week.ago) }

 def validate_only_one_signup_per_week
    if User.where(:email => self.email).in_the_past_week.any?
      self.errors.add(:email, 'can only one be entered once per week')
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
  
  

