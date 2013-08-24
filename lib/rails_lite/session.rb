require 'json'
require 'webrick'

class Session
  def initialize(req)
    @cookie_value=nil
    req.cookies.each do |cookie|
      @cookie_value = JSON.parse(cookie.value) if cookie.name == '_rails_lite_app'
    end
    @cookie_value ||= {}
  end

  def [](key)
    @cookie_value[key]
  end

  def []=(key, val)
    @cookie_value[key] = val
  end

  def store_session(res)
    res.cookies << WEBrick::Cookie.new('_rails_lite_app', @cookie_value.to_json)
  end
end
