require 'pry'
require 'lib/aggregator'
activate :aggregator

I18n.enforce_available_locales = false

###
# Blog settings
###

# Time.zone = "UTC"

activate :blog do |blog|
  blog.name = "blog"
  blog.prefix = "blog"
  blog.sources = "{title}.html"
  blog.permalink = "{year}/{month}/{title}.html"
  blog.summary_separator = /(READMORE)/
  blog.paginate = true
  blog.year_template = "blog-archive-by-year.html"
  blog.month_template = "blog-archive-by-month.html"
  blog.taglink = "categories/{tag}.html"
  blog.tag_template = "category.html"
end

activate :blog do |blog|
  blog.name = "episodes"
  blog.prefix = "episodes"
  blog.sources = "{number}-{title}.html"
  blog.permalink = "{title}.html"
  blog.summary_separator = /(READMORE)/
  blog.paginate = true
  blog.taglink = "categories/{tag}.html"
  blog.tag_template = "category.html"
end

page "/feeds/ogg", layout: false
page "/episodes.json", layout: false

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (http://middlemanapp.com/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

def transcript_count
  Dir[File.join('source', 'transcripts', '*')].count do |file|
    File.file?(file)
  end
end

def extract_number_from_path(glob)
  Dir[glob].map { |path| path.slice(/\d+/) }
end

glob = File.join("source", "transcripts", "*", "en.md")
extract_number_from_path(glob).each do |number|
  proxy "/episodes/#{number}/transcript.html", "/transcripts/#{number}/en.html"
end

languages = %w{fr}
languages.each do |lang|
  glob = File.join("source", "transcripts", "*", "#{lang}.md")
  extract_number_from_path(glob).each do |number|
    proxy "/episodes/#{number}/transcript/#{lang}.html", "/transcripts/#{number}/#{lang}.html"
  end
end

proxy "/episodes/all.html", "/episodes-all.html"

["registers", "fugitive", "vimgolf", "folding"].each do |category|
  proxy "categories/#{category}.html", "category-aggregate.html", locals: { tagname: category }, ignore: true
end

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

activate :directory_indexes

# Reload the browser automatically whenever files change
activate :livereload

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

set :css_dir, 'stylesheets'

set :js_dir, 'javascripts'

set :images_dir, 'images'

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  # activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript

  # Enable cache buster
  # activate :asset_hash

  # Use relative URLs
  # activate :relative_assets

  # Or use a different image path
  # set :http_prefix, "/Content/images/"

  # Redirects
  ready do
    redirect "e/a.html", to: "/episodes/all"
    blog(:episodes).articles.each do |episode|
      n = episode.data.number
      redirect "episodes/#{n}.html", to: episode.path
      redirect "e/#{n}.html", to: episode.path
      redirect "e/#{n}/t.html", to: "/episodes/#{n}/transcript"
    end
    # blog(:blog).articles.each do |post|
    #   redirect post.path, to: post.destination_path
    # end
  end

end

def save_tags_to_yaml
  tags = (blog(:blog).tags.keys + blog(:episodes).tags.keys).uniq
  File.open('data/categories.yml', 'w') { |f| f.write tags.to_yaml }
end

ready do
  save_tags_to_yaml
end

# Uncomment next line to use Pry as a console
# ready { binding.pry }
