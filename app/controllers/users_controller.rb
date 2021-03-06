class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(new create index)
  before_action :correct_user, only: %i(edit update)
  before_action :admin_user, only: :destroy

  def index
    @users = User.page(params[:page]).per Settings.paginate_user
  end

  def show
    @microposts = @user.microposts.create_desc.page(params[:page])
                       .per_page Settings.paginate_post
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash.now[:info] = t ".email"
      redirect_to root_url
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = t ".updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    flash[:success] = if @user.admin?
                        t ".danger"
                      elsif @user.destroy
                        t ".deleted"
                      else
                        t ".notice"
                      end
    redirect_to users_url
  end

  private

  def logged_in_user
    return if logged_in?
    store_location
    flash.now[:danger] = t ".please_login"
    redirect_to login_url
  end

  def correct_user
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash.now[:warrning] = t ".user_not_found"
    redirect_to root_path
  end
end
