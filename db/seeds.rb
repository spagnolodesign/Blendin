#Blend.create! sender_id:1248, recipient_id:40, message:"Hello I would like to connect wit you :)"
#Blend.destroy_all
#AdminUser.create!(email: 'admin@blendinnow.nl', password: 'blendin##2017', password_confirmation: 'blendin##2017')
# def remove_space_and_special_char number
#   return number.to_s.scan(/[\d]+/).join
# end
#
# User.all.each do |user|
#
#   valid_string = !user.phone.nil? && !user.phone.empty? && (user.phone.length > 0)
#
#   if valid_string
#     number = remove_space_and_special_char user.phone
#     prefix = number[0..1]
#     case prefix
#       when "00" then prefix = "+"
#       when "31" then prefix = "+#{prefix}"
#       when "06" then prefix = "+316"
#     end
#     valid_number = prefix.to_s + number[2..-1].to_s
#     p valid_number
#   end
#
# end
