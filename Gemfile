# If you have OpenSSL installed, we recommend updating
# the following line to use "https"
source 'http://rubygems.org'

gem "middleman"
gem "middleman-blog", "~> 3.5.1"
gem 'middleman-s3_sync'
gem "middleman-syntax"
gem "nokogiri"
gem "redcarpet"

# For feed.xml.builder
gem "builder", "~> 3.0"

# Live-reloading plugin
gem "middleman-livereload", "~> 3.1.0"

gem "pry"

# For faster file watcher updates on Windows:
gem "wdm", "~> 0.1.0", :platforms => [:mswin, :mingw]

# Cross-templating language block fix for Ruby 1.8
platforms :mri_18 do
  gem "ruby18_source_location"
end
