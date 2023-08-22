class LicenseRequestRecording < ActiveRecord::Base
	belongs_to :license_request
	belongs_to :recording
end
