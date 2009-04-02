run "echo TODO > README"

gem   'thoughtbot-factory_girl',  :lib => 'factory_girl',   :source => "gems.github.com"
gem   'mislav-will_paginate',     :lib => 'will_paginate',  :source => "gems.github.com"
gem   'paperclip',                :lib => 'paperclip'
gem   'mocha',                    :lib => 'mocha'
gem   'cucumber',                 :lib => 'cucumber'
gem   'rubyist-aasm',             :lib => 'aasm'

if yes?("Do you want to use haml")
  gem       'haml',                      :lib => 'haml'
  generate  'haml'
end
if yes?("Do you want to use rspec")
  plugin "rspec",       :git => "git://github.com/dchelimsky/rspec.git"
  plugin "rspec-rails", :git => "git://github.com/dchelimsky/rspec-rails.git"
  generate :rspec
else
  gem   'thoughtbot-shoulda',       :lib => "shoulda",        :source => "gems.github.com"
  gem   'seanhussey-woulda',        :lib => "woulda",         :source => "gems.github.com"
end

plugin "resource_controller", :git => "git://github.com/giraffesoft/resource_controller.git"
rake  "gems:install"

generate :controller, "pages"
route "map.root :controller => 'pages'"
git :rm => 'public/index.html'

git :init

file ".gitignore", <<-END
.DS_Store
log/*.log
tmp/**/*
config.database.yml
db/*.sqlite3
END

run "touch tmp/.gitignore log/.gitignore vendor/.gitignore"
run "cp config/database.yml config/example_database.yml"

git :add => ".", :commit => "-m initial commit"
