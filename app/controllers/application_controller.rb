class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  before_action(:force_user_sign_in)
  skip_before_action(:force_user_sign_in, { :only => [:homepage] })
  
  before_action(:get_path)
  before_action(:get_username)
  
  def get_path
    @path = request.fullpath
  end

  def get_username
    name_array = @current_user.email.split("@")
    @username = name_array[0].capitalize
  end

  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def homepage
    render({ :template => "index.html.erb" })
  end

end
