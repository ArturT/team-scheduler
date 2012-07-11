module ApplicationHelper
  # @param title:string
  # @param path:string
  # @param options:{}
  # @return string link to path
  def menu_item(title, path, options = {})
    options.reverse_merge!(:class => '')
    puts request.path
    if (request.path.match(/#{path}/) && path != "/") || (request.path == "/" && path == "/")
      options[:class] << ' active'
    end
    link_to title, path, options
  end

  # @param title:string
  # @param path:string
  # @param options:{}
  # @return string <li> element with class="active"
  def li_menu_item(title, path, options = {})
    options.reverse_merge!(:class => '')
    puts request.path
    if (request.path.match(/#{path}/) && path != "/") || (request.path == "/" && path == "/")
      raw '<li class="active">' << link_to(title, path, options) << '</li>'
    else
      raw '<li>' << link_to(title, path, options) << '</li>'
    end
  end
end

class String
  # http://stackoverflow.com/a/2955911  
  def is_date?
    begin
       Date.parse(self)
       true
    rescue
       #do something if invalid
       false
    end
  end
end