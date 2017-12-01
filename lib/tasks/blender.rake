namespace :blender do

  desc "Send reminder to all pending blend"
  task reminder: :environment do
    @pending_blend = Blend.where(status:'pending')

    @pending_blend.each do |blend|
      puts "send email"
      blend.send_blend_request_email
    end

  end

end
