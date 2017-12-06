namespace :blender do

  desc "Send reminder to all pending blend"
  task reminder: :environment do
    today = Date.today
    if today.friday?
      @pending_blend = Blend.where(status:'pending')

      @pending_blend.each do |blend|
        if (blend.sender && blend.recipient)
          puts "send blend request: from #{blend.sender.username} to #{blend.recipient.username}"
          blend.send_blend_request_email
        else
          blend.destroy
        end
        sleep 0.2
      end
    end

  end

end
