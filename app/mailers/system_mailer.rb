class SystemMailer < ApplicationMailer
	default from: "Twin Musicom <info@twinmusicom.org>"

	def contact_us(name, email, message)
		@name = name
		@message = message
		mail(to: 'kenyon@gyra.cc', reply_to: name + '<' + email + '>', subject: 'TM Website Contact from ' + name)
	end
end
