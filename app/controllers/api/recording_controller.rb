class Api::RecordingController < ApplicationController
	include Api::RecordingHelper
	def index
		r = Recording.find_by(recording_id: params[:recording_id])

		render json: get_recording_data(r)
	end

	def info
		recordings = Recording.where(recording_id: params[:recording_ids])

		out = []
		recordings.each do |r|
			out.push(get_recording_data(r))
		end

		render json: out
	end
end
