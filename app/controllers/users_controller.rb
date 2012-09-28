class UsersController < ApplicationController
  def new
    @entry = Entry.new
    @user = User.new

  end

  def create
    @user = User.find_or_initialize_by_email(params[:user])
    referralKey = params[:user][:referral]
    @user.update_attributes(params[:user])
    random = (Random.rand(100_000-10_000)+10_000).to_s
    @user.referral_key = random + @user.id.to_s if @user.referral_key.blank?
    if @user.save
      @user.create_entries(referralKey)
      redirect_to ('/thankYou')#, notice: 'referral id: ' + referralKey + @user.referral_key
    else
      render "new"
    end
  end
  
  def update
    @user = User.find(params[:id])
    referralKey = params[:user][:referral]
    @user.update_attributes(params[:user])
    if @user.save
      @user.create_entries(referralKey)
      redirect_to ('/thankYou')#, notice: 'referral id: ' + referralKey + @user.referral_key
    else
      render "new"
    end
  end

  def index
    @users = User.all
    
    @DBusers = User.all
    respond_to do |format|
      format.html
      format.xls do
        render :xls => @DBusers,
        :columns => [ :first_name, :last_name, :email, :created_at ],
        :headers => %w[ First_Name Last_name Email Submit_Date ]
      end
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    
    redirect_to users_path
  end

end

