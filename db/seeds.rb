#Blend.create! sender_id:1248, recipient_id:40, message:"Hello I would like to connect wit you :)"
#Blend.destroy_all
AdminUser.create!(email: 'admin@blendinnow.nl', password: 'blendin##2017', password_confirmation: 'blendin##2017')
