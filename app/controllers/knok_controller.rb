class KnokController < ApplicationController

	def like
		@knok = Knok.create! from_id: current_user.id, to_id: params[:user_id], liked: true
		respond_to do |format|
			if @knok.save
        format.html { redirect_to root_path, notice: 'Thank you from the team of blendin, we will get back to you soon, PS: Spread the love.' }
				format.json
      else
        format.html { redirect_to root_path }
				format.json
      end
		end
	end

	def connect
		@user = User.find(params[:user_id])
	end


end
