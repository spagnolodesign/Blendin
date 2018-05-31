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


Event.destroy_all
Participant.destroy_all

5.times do
  Event.create(
    name: Faker::BossaNova.song,
    date: Date.today + rand(20..40),
    time: "2000-01-01 20:00:00",
    description: "Lorem ipsum dolor sit amet, legere graecis duo at. Mei augue movet ne. Appetere delicata vis id. Has alii illud cu, est ea tritani partiendo rationibus. His mazim ornatus pericula ne, esse graeci nec ei.
    In timeam epicuri placerat mea, phaedrum iudicabit cum te. Ut ferri inimicus sed, et cum facer corrumpit, omnes voluptaria et nec. Nam liber paulo posidonium ex. Ad eius omnesque fabellas eos, modus dicam consul duo id. Offendit recteque pro ea. At electram similique quo. Te nulla cetero inermis eam, pri facer epicuri in.",
    city: Faker::Address.city,
    max_refugee_capacity: 5,
    max_local_capacity: 5,
    community_events: false
  )
end

3.times do
  Event.create(
    name: Faker::BossaNova.song,
    date: Date.today + rand(20..40),
    time: "2000-01-01 20:00:00",
    description: "Lorem ipsum dolor sit amet, legere graecis duo at. Mei augue movet ne. Appetere delicata vis id. Has alii illud cu, est ea tritani partiendo rationibus. His mazim ornatus pericula ne, esse graeci nec ei.
    In timeam epicuri placerat mea, phaedrum iudicabit cum te. Ut ferri inimicus sed, et cum facer corrumpit, omnes voluptaria et nec. Nam liber paulo posidonium ex. Ad eius omnesque fabellas eos, modus dicam consul duo id. Offendit recteque pro ea. At electram similique quo. Te nulla cetero inermis eam, pri facer epicuri in.",
    city: Faker::Address.city,
    topic: "Music",
    community_events: true
  )
end

refugee = User.where(local: false)
local = User.where(local: true)


Event.all.each do |event|
  rand(1..4).times do
    Participant.create(
    event: event,
    user_id: refugee.sample.id
  )
  end
  rand(1..4).times do
    Participant.create(
    event: event,
    user_id: local.sample.id
  )
  end
end
