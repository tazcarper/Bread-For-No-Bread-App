class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name
  before_save { |user| user.email = email.downcase }
  
  
  validates :first_name,  :presence => { :message => " Please enter first name" }, length: { maximum: 50, :message => "First name cant be over 50 characters" }
  validates :last_name,  :presence => { :message => " Please enter last name" }, length: { maximum: 50, :message => "First name cant be over 50 characters" } 
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => { :message => "Please enter email" }, format: { with: VALID_EMAIL_REGEX, :message => "Must be valid email." }, 
  uniqueness: { case_sensitive: false, :message => "That email is taken" }
  
  # validates :check1, acceptance: true
  # validates :check2, acceptance: true
  
  # validates_acceptance_of :check1, :allow_nil => false, :message => "Checkbox 1 must be checked."
  # validates_acceptance_of :check2, :accept => true,  :message => "Checkbox 2 must be checked."
  
  
end
