class KnokController < ApplicationController

	def like
		# Knok.create! from_id: 11, to_id: 5, liked: true

		@noc = Knok.create! from_id: current_user.id, to_id: params[:id], liked: true
		@isAlredyLike = Knok.all.where(from_id: params[:id], to_id: current_user.id)
    
		respond_to do |format|
      if @noc.save
      	if !@isAlredyLike.empty?
      		subscription = create_subscription(current_user.id, params[:id])

      		event_json_match = {
			      "event" => "is_match",
			      "data" => subscription
			    }

			  	format.json { render json: event_json_match }
				else
					event_json_noc = {
						"event" => "is_noc",
						"data" => @noc
					}
					format.json { render json: event_json_noc }
				end
      else
        format.json { render json: @noc.errors, status: :unprocessable_entity }
      end
    end


	end

	def dislike
		
	end

	private 

  def create_subscription (user_one, user_two)
  	uniqChatRoom = ChatRoom.create
  	Subscription.create! user_id: user_one, chat_room_id: uniqChatRoom.id
  	Subscription.create! user_id: user_two, chat_room_id: uniqChatRoom.id
  	return uniqChatRoom
  end



end
