namespace :messages do
  desc "TODO"

  task unread: :environment do
  	
  	User.all.each do | user |
  		if Message.unread_by(user).present?
		    UserMailer.message_unread(user).deliver
  		end	
  	end

  	Message.cleanup_read_marks!

  end

end
