class UsersController < ApplicationController
  def new
    @entry = Entry.new
    @user = User.new

  end

  def create
    @user = User.new(params[:user])
    referralKey = @user.referral
    if @user.save      
      random = (Random.rand(100_000-10_000)+10_000).to_s
      @user.referral_key = random + @user.id.to_s
      @user.save
      @entry = Entry.new
      @entry.user_id = @user.referral_key
      @entry.save
      if User.exists?(:referral_key => referralKey)
        @refEntry = Entry.new
        @refEntry.user_id = referralKey
        @refEntry.save
      end
      redirect_to ('/thankYou')#, notice: 'referral id: ' + referralKey
    else
      render "new"
    end
  end
  
  def update
    
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

