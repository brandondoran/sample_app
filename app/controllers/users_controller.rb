class UsersController < ApplicationController
  before_action :signed_in_user,  only: [:index, :edit, :update, :destroy]
  before_action :correct_user,    only: [:edit, :update]
  before_action :admin_user,      only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
    if signed_in?
      redirect_to root_path
    else
     @user = User.new
    end
  end

  def show
  	@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    if signed_in?
      redirect_to root_path
    else
    	@user = User.new(user_params)
    	if @user.save
        sign_in @user
        flash[:success] = "Welcome to the Sample App"
    		redirect_to @user
    	else
    		render 'new'
    	end
    end
  end

  def destroy
    user = User.find(params[:id])
    if current_user?(user)
      flash[:error] = "Sorry, you cannot destory your own profile." 
    else
      user.destroy
      flash[:success] = "User destroyed."
    end

    redirect_to users_url
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

  	def user_params
  		params.require(:user).permit(:name, :email, :password, 
  			:password_confirmation)
  	end

    # before filters
    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "please sign in." unless signed_in?
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
