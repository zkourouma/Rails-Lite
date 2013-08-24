require 'erb'
require 'active_support/core_ext'
require 'url_helper'
require 'helper'
require_relative 'params'
require_relative 'session'
require_relative 'csrf'


class ControllerBase
  attr_reader :params
  include Csrf
  include Helper


  def initialize(req, res, route_params="/")
    @req, @res = req, res
    @params = Params.new(@req, route_params)
    store_csrf
  end

  def session
    @session||= Session.new(@req)
  end

  def already_rendered?
    @already_rendered
  end

  def redirect_to(url="http://www.google.com")
    unless @response_built
      @res.status = 302
      @res['location'] = url
      session.store_session(@res)
      @response_built = true
    end
  end

  def render_content(content, type)
    unless already_rendered?
      @res.content_type = type
      @res.body = content
      session.store_session(@res)
      @already_rendered = true
    end
  end

  def render(template_name=nil, *partially)
    unless template_name == :partial
      controller_name = self.class.to_s.underscore
      template_file = File.read("views/#{controller_name}/#{template_name}.html.erb")
    end

    if template_name == :partial
      partial_file = File.read("/views/shared/_#{partially}.html.erb")
      return ERB.new(partial_file).result(binding)  
    end

    content = ERB.new(template_file).result(binding)
    render_content(content, 'html')

    flash = nil
  end

  def invoke_action(name)
    send(name)|| (render name)
  end

  def flash
    @flash ||= Session.new(@req)
  end

  def self.helper(module_name)
    include module_name
  end
end
