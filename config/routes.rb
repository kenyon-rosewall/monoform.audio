Rails.application.routes.draw do
  root 'home#index'

  #Home
  get '/login', to: 'home#login'
  get '/logout', to: 'home#logout'
  get '/profile', to: 'home#profile'
  get  '/cart', to: 'home#cart'
  get '/thanks/:type', to: 'home#thanks'

  #Music
  get '/music', to: 'music#index'
  get '/music/creative_commons', to: 'music#creative_commons'
  get '/music/commercial_music', to: 'music#commercial_music'
  get '/music/download', to: 'music#download'
  get '/music/download/:recording_id', to: 'music#download'
  get '/music/song/:id/:slug', to: 'music#song'
  get '/music/song/:old_id', to: 'music#legacy_song'
  post '/music/recording/:id/post_comment', to: 'music#post_comment'
  get '/music/artists', to: 'music#artists'
  get '/music/view_artist/:artist_id/:slug', to: 'music#view_artist'
  get '/music/playlists', to: 'music#playlists'
  get '/music/view_playlist/:playlist_id/:slug', to: 'music#view_playlist'
  get '/music/:query', to: 'music#index'

  #Info
  get '/info', to: 'info#index'
  get '/info/about_us', to: 'info#about_us'
  get '/info/reel', to: 'info#reel'
  get '/info/credits', to: 'info#credits'
  get '/info/testimonials', to: 'info#testimonials'
  get '/info/privacy_policy', to: 'info#privacy_policy'
  get '/info/license_agreement', to: 'info#license_agreement'
  get '/info/site_map', to: 'info#site_map'
  get '/info/licensing', to: 'info#licensing'

  #Support
  get '/support', to: 'support#index'
  get '/support/faq', to: 'support#faq'
  get '/support/contact_us', to: 'support#contact_us'
  get '/support/contact_us/:recording_id', to: 'support#contact_us'
  post '/support/contact', to: 'support#contact'
  get '/support/custom_score', to: 'support#custom_score'
  get '/support/cue_sheets', to: 'support#cue_sheets'
  get '/support/submit', to: 'support#submit'
  post '/support/submit', to: 'support#submit_action'
  post '/support/submit_license_request', to: 'support#submit_license_request'

  #Redirects
  get '/faq', to: redirect('/support/faq')
  get '/licenses', to: redirect('/support/licenses')
  get '/news', to: redirect('/')
  get '/about', to: redirect('/info/about_us')
  get '/song/:old_id/:title', to: redirect('/music/song/%{old_id}')
  get '/download_file', to: redirect('/music/download')

  get '/admin', to: 'admin#index'
  get '/admin/login', to: 'admin#login'
  post '/admin/authorize', to: 'admin#authorize'
  namespace :admin do
    resources :songs
    post '/songs/:song_id/add_composer', to: 'songs#add_composer'
    delete '/songs/:song_id/remove_composer', to: 'songs#remove_composer'
    post '/songs/:song_id/add_publisher', to: 'songs#add_publisher'
    delete '/songs/:song_id/remove_publisher', to: 'songs#remove_publisher'
    post '/songs/:song_id/add_recording', to: 'songs#add_recording'
    delete '/songs/:song_id/remove_recording', to: 'songs#remove_recording'
    put '/songs/:song_id/inactivate', to: 'songs#inactivate'
    put '/songs/:song_id/activate', to: 'songs#activate'
    resources :composers
    put '/composers/:composer_id/inactivate', to: 'composers#inactivate'
    put '/composers/:composer_id/activate', to: 'composers#activate'
    resources :publishers
    put '/publishers/:publisher_id/inactivate', to: 'publishers#inactivate'
    put '/publishers/:publisher_id/activate', to: 'publishers#activate'
    resources :artists
    put '/artists/:artist_id/inactivate', to: 'artists#inactivate'
    put '/artists/:artist_id/activate', to: 'artists#activate'
    resources :recordings
    post '/recordings/:recording_id/add_artist', to: 'recordings#add_artist'
    delete '/recordings/:recording_id/remove_artist', to: 'recordings#remove_artist'
    post '/recordings/:recording_id/add_genre', to: 'recordings#add_genre'
    delete '/recordings/:recording_id/remove_genre', to: 'recordings#remove_genre'
    post '/recordings/:recording_id/add_library', to: 'recordings#add_library'
    delete '/recordings/:recording_id/remove_library', to: 'recordings#remove_library'
    post '/recordings/:recording_id/add_tag', to: 'recordings#add_tag'
    delete '/recordings/:recording_id/remove_tag', to: 'recordings#remove_tag'
    get '/recordings/:recording_id/reencode_files', to: 'recordings#reencode_files'
    resources :tags
    resources :libraries
    put '/libraries/:library_id/inactivate', to: 'libraries#inactivate'
    put '/libraries/:library_id/activate', to: 'libraries#activate'
    resources :playlists
    post '/playlists/:playlist_id/add_recording', to: 'playlists#add_recording'
    delete '/playlists/:playlist_id/remove_recording', to: 'playlists#remove_recording'
    put '/playlists/:playlist_id/inactivate', to: 'playlists#inactivate'
    put '/playlists/:playlist_id/activate', to: 'playlists#activate'
    resources :genres
    resources :licenses
    put '/licenses/:license_id/inactivate', to: 'licenses#inactivate'
    put '/licenses/:license_id/activate', to: 'licenses#activate'
    get '/submissions', to: 'submissions#index'
    get '/submissions/:id', to: 'submissions#view'
    delete '/submissions/:id', to: 'submissions#delete'
    resources :quotes
    resources :requests
  end

  namespace :api do
    get '/search/recordings', to: 'search#recordings'
    get '/search/recordings/:term', to: 'search#recordings'
    get '/search/songs', to: 'search#songs'
    get '/search/recommended_songs', to: 'search#recommended_songs'
    get '/search/new_songs', to: 'search#new_songs'
    get '/search/songs/:query', to: 'search#songs'
    get '/recording/info', to: 'recording#info'
    get '/recording/:recording_id', to: 'recording#index'
  end
end
