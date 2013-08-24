module Helper
  def link_to(body, url)
    '<a href="#{url}">#{body}</a>'
  end

  def button_to(action=nil)
    '<form action="/#{self.class.to_s.underscore}/#{action}" method="post">
          <input type="submit" value="#{action} #{self.class.to_s.underscore}"
          </form>'
  end
end