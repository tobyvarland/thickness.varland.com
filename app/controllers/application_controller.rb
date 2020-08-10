class ApplicationController < ActionController::Base

  # Alloy pagination.
  include Pagy::Backend

  # Make methods accessible as helpers.
  helper_method :current_user
  helper_method :logged_in?

  # Gets reference to current user.
  def current_user    
    id = session[:user_id].blank? ? cookies[:user_id] : session[:user_id]
    User.find_by(id: id)  
  end

  # Determines if user is logged in.
  def logged_in?
    !current_user.blank?  
  end

  def authorized
    redirect_to(login_url) unless logged_in?
  end

  def authorized_as_supervisor
    redirect_to(login_url) and return unless logged_in?
    redirect_to(root_url, flash: {error: "You are not authorized to access that page. Please contact IT if you need help."}) unless current_user.access_level_before_type_cast >= 2
  end

  def authorized_as_admin
    redirect_to(login_url) and return unless logged_in?
    redirect_to(root_url, flash: {error: "You are not authorized to access that page. Please contact IT if you need help."}) unless current_user.access_level_before_type_cast == 3
  end

  # Persist filters to cookies.
  def filters_to_cookies(filters)

    filters.each do |f|
      cookie_name = global ? f : "#{params[:controller]}_#{params[:action]}_#{f}"
      if params[:reset]
        cookies[cookie_name] = ""
      else
        if params[f]
          cookies[cookie_name] = { value: params[f], expires: 1.hour.from_now }
        else
          if cookies[cookie_name]
            params[f] = cookies[cookie_name]
          end
        end
      end
    end
  end

end