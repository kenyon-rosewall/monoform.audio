module Api::RecordingHelper
	def get_recording_data(r)
		out = {}
		out['real_id'] = r.id
		out['title'] = r.song.name
		out['version'] = r.name
		out['full_title'] = r.full_title
		out['slug'] = r.slug
		out['id'] = r.recording_id
		out['src'] = r.watermarked_path
		out['waveform'] = r.waveform_path
		out['length'] = r.length
		if r.artists.first
			out['artist'] = r.artists.first.name
			out['artist_id'] = r.artists.first.id
			out['artist_slug'] = r.artists.first.slug
		end

		out
	end
end
