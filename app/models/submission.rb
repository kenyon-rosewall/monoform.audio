class Submission < ActiveRecord::Base
	before_create :assign_submission_id
	before_destroy :delete_files

	def base_path
		"#{Rails.root}/public"
	end

	def delete_files
		if self.submission_id
			folder = "./public/submissions/" + self.submission_id
			if File.directory? folder
				FileUtils.rm_r(folder)
			end
		end
	end

	def assign_submission_id
		self.submission_id = new_submission_id
	end

	def write_file(uploaded_file)
		dir = base_path + "/submissions/" + self.submission_id + "/"
		FileUtils.mkdir_p(dir)
		filepath = dir + uploaded_file.original_filename
		File.open(filepath, 'wb') do |file|
			file.write(uploaded_file.read)
		end
	end

	def files
		Dir[base_path + '/submissions/' + self.submission_id + '/*.*'].collect { |f|
			if f != '.' or f != '..'
				f.gsub(base_path + '/submissions/' + self.submission_id + '/','')
			end
		}
	end
private
	def new_submission_id
		begin
			submissionid = rand(36**8).to_s(36)
		end while Submission.find_by(submission_id: submissionid)

		submissionid
	end
end
