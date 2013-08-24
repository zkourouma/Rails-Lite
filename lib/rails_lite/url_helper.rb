module UrlHelper
  require 'active_support/core_ext'

  define_method(:"#{self.class.name.to_s.underscore}_path") do 
    '/#{self.class.name.to_s.underscore.pluralize}'
  end

  define_method(:"new_#{self.class.name.to_s.underscore}_path") do
    '/#{self.class.name.to_s.underscore.pluralize}/new'
  end

  define_method(:"edit_#{self.class.name.to_s.underscore}_path") do |*args| 
    '/#{self.class.name.to_s.underscore.pluralize}/edit/#{args.id}'
  end

  define_method(:"#{self.class.name.to_s.underscore}_path") do |*args| 
    '/#{self.class.name.to_s.underscore.pluralize}/#{args.id}'
  end
end