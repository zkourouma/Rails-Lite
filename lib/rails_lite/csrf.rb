class Csrf
  @token = nil


  def store_csrf
    @token = SecureRandom.urlsafe_base64
    session[:_csrf_token] ||= @token
  end
end