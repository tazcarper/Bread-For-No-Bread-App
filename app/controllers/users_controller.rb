class UsersController < ApplicationController
  def new
      @user = User.new
      
    end

    def create
       @user = User.new(params[:user])
       if @user.save
         redirect_to ('/thankYou')
       else
         render 'new'
       end
     end
  
     def index
       @user = User.new
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
  
end

