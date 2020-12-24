class ApplicationController < ActionController::Base

  before_action :set_current_user

  before_action :set_search

  def set_search
    @search = Post.ransack(params[:q])
    @searched_posts = @search.result.order(created_at: :desc)
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "Please login to your account."
      redirect_to("/login")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "Your account is already logged in."
      redirect_to("/posts/index")
    end
  end

end
