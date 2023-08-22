# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.twinmusicom.org"

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end

  add '/'
  
  add '/music'
  add '/music/creative_commons'
  add '/music/commercial_music'
  add '/music/artists'
  add '/music/playlists'

  Recording.find_each do |r|
    add '/music/song/' + r.id.to_s + '/' + r.slug
  end

  add '/info'
  add '/info/about_us'
  add '/info/reel'
  #add '/info/credits'
  #add '/info/testimonials'
  add '/info/privacy_policy'
  add '/info/license_agreement'
  add '/info/site_map'

  add '/support'
  add '/support/faq'
  add '/support/licenses'
  add '/support/contact_us'
  add '/support/custom_score'
  #add '/support/cue_sheets'
  add '/support/submit'
end
