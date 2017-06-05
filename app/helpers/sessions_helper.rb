module SessionsHelper

  def log_in(user)
    cookies.permanent.signed[:user_id] = user.id
  end

  def log_out
    cookies.delete(:user_id)
  end

  def is_logged_in?
    !cookies.permanent.signed[:user_id].nil?
  end

end
