class SupportController < ApplicationController
	include ApplicationHelper

	def index
		
	end

	def faq
		
	end

	def contact_us
		if params.has_key? :recording_id
			@song_title = Recording.find_by(recording_id: params[:recording_id]).full_title
			@recording_id = params[:recording_id]
		end
	end

	def contact
		err = ''
		payload = {
			"secret" => ENV['RECAPTCHA_SECRET'],
			"response" => params["g-recaptcha-response"],
			"remoteip" => request.remote_ip
		}
		response = post_data(ENV['RECAPTCHA_URL'], payload)

		if response["success"] == true
			SystemMailer.contact_us(params[:name], params[:email], params[:message]).deliver
		else
			if response["error-codes"].include? 'missing-input-response'
				err += "Missing reCaptcha input <br>"
			end
		end

		if err != ''
			flash[:error] = err
		end

		redirect_to support_contact_us_path
	end

	def custom_score
		
	end

	def cue_sheets
		
	end

	def submit
		
	end

	def submit_action
		err = ''

		if params.has_key? :verify_ownership and params[:verify_ownership] == 'on'
			payload = {
				"secret" => ENV['RECAPTCHA_SECRET'],
				"response" => params["g-recaptcha-response"],
				"remoteip" => request.remote_ip
			}
			response = post_data(ENV['RECAPTCHA_URL'], payload)

			if response["success"] == true
				# puts params[:verify_ownership]
				s = Submission.create(
					name: params[:name],
					email: params[:email],
					message: params[:message],
					artist: params[:artist],
					sounds_like: params[:sounds_like],
					how_did_you_hear: params[:how_did_you_hear]
					)

				if params[:song0]
					s.write_file(params[:song0])
				end

				if params[:song1]
					s.write_file(params[:song1])
				end

				if params[:song2]
					s.write_file(params[:song2])
				end

				if params[:song3]
					s.write_file(params[:song3])
				end
			else
				if response["error-codes"].include? 'missing-input-response'
					err += "Missing reCaptcha input <br>"
				end
			end
		else
			err += "Please verify that you own the music you are submitting <br>"
		end

		if err != ''
			flash[:error] = err
			redirect_to support_submit_path
		else
			redirect_to controller: "home", action: "thanks", type: "music_submit"
		end
	end

	def submit_license_request
		err = ''

		payload = {
			"secret" => ENV['RECAPTCHA_SECRET'],
			"response" => params["g-recaptcha-response"],
			"remoteip" => request.remote_ip
		}
		response = post_data(ENV['RECAPTCHA_URL'], payload)

		if response["success"] == true
			request = LicenseRequest.create(
				name: params[:name],
				organization: params[:organization],
				email: params[:email],
				phone: params[:phone],
				project_name: params[:project_name],
				project_description: params[:project_description],
				song_use: params[:song_use],
				budget: params[:budget],
				timeline: params[:timeline],
				alterations: params[:alterations],
				notes: params[:notes]
				)

			recordings = Recording.where(recording_id: params[:songs_for_request].split(','))
			recordings.each do |r|
				LicenseRequestRecording.create(license_request_id: request.id, recording_id: r.id)
			end
		else
			if response["error-codes"].include? 'missing-input-response'
				err += "Missing reCaptcha input <br>"
			end
		end

		if err != ''
			flash[:error] = err
			redirect_to controller: "home", action: "cart"
		else
			redirect_to controller: "home", action: "thanks", type: "license_request"
		end
	end
end
