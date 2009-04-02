load_template "http://github.com/mattbeedle/templates/raw/master/base.rb"

gem 'authlogic',  :lib => 'authlogic'
name = ask("What do you want your user to be called")
generate :session, "#{name}_session"
generate :model, name
rake "gems:install"

# TODO rspec controllers if using rspec
generate :controller, "sessions"
generate :controller, name.pluralize

route "map.resource :session"
if yes?("Use plural user resource")
  route "map.resources #{name.pluralize.to_sym}"
else
  route "map.resource #{name.to_sym}"
end

git :add => ".", :commit => "-m 'adding authentication'"
