class LicenseRequest < ActiveRecord::Base
	has_many :license_request_recordings
	has_many :recordings, :through => :license_request_recordings
end
