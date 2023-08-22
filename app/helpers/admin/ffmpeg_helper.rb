module Admin::FfmpegHelper
	def ffmpeg_binary
		"/usr/local/bin/ffmpeg"
	end

	def ffprobe_binary
		"/usr/local/bin/ffprobe"
	end

	def encode_mp3(input, output)
		command = ffmpeg_binary + " -i #{input} -codec:a libmp3lame -qscale:a 4 #{output}"

		run_command(command)
	end

	def create_watermarked(input, output)
		watermark_file = Rails.root.to_s + "/public/WATERMARK.wav"
		command = ffmpeg_binary + " -i #{input} -i #{watermark_file} -filter_complex \"[0:0][1:0] amix=inputs=2:duration=shortest\" -ac 2 -codec:a libmp3lame -qscale:a 7 #{output}"

		run_command(command)
	end

	def create_waveform(input, output)
		command = ffmpeg_binary + " -i #{input} -filter_complex \"showwavespic=s=640x120\" -frames:v 1 #{output}"

		run_command(command)
	end

	def get_duration(input)
		command = ffprobe_binary + " -v quiet -print_format json -show_format #{input}"
		output = ""

		Open3.popen3(command) do |stdin, stdout, stderr, thread|
			stdout.each do |line|
				output = output + line
			end
		end

		if output = JSON.parse(output)
			# output = JSON.parse(output)
			output["format"]["duration"]
		else
			"0:00"
		end
	end

	def get_metadata(input)
		command = ffprobe_binary + " -v quiet -print_format json -show_format #{input}"
		output = ""

		Open3.popen3(command) do |stdin, stdout, stderr, thread|
			stdout.each do |line|
				output = output + line
			end
		end

		output
	end

	def run_command(command)
		Open3.popen3(command) do |stdin, stdout, stderr, thread|
			stderr.each do |line|
				puts line
			end
		end
	end
end
