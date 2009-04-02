load_template "http://github.com/mattbeedle/templates/raw/master/base.rb"

gem 'authlogic',  :lib => 'authlogic'
rake "gems:install"
name = ask("What do you want your user to be called")
generate :session, "#{name.downcase}_session"
generate :model, name.downcase

# TODO rspec controllers if using rspec
generate :controller, "sessions"
generate :controller, name.downcase.pluralize

route "map.resource :session"
if yes?("Use plural user resource")
  route "map.resources :#{name.downcase.pluralize}"
else
  route "map.resource :#{name.downcase}"
end

git :add => ".", :commit => "-m 'adding authentication'"
