require 'webrick'

trap('INT') { server.shutdown}

server = WEBrick::HTTPServer.new :Port => 8080

server.mount_proc '/' do |req, res|
    res.content_type = 'text/text'
    res.body = req.path
end

class ControllerBase
  def initialize(HTTPRequest, HTTPResponse)
    @httprequest, @httpresponse = HTTPRequest, HTTPResponse
  end

  def render_content(body, content_type)
    @httpresponse.content_type = content_type
    @httpresponse.body = body
    @already_rendered = @httpresponse
  end

  def redirect_to(url)
    @httpresponse.status = 302
    @httpresponse.header = "HTTP/1.1"
    @response_built = @httpresponse
  end
end