namespace :tm do
  desc "Generate all mp3s, etc"
  task generate_files: :environment do
  	Recording.all.each do |r|
	  	r.encode_files
	  	r.create_images
	  	sleep(40)
	 end
  end

end
