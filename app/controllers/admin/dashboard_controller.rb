class Admin::DashboardController < Admin::AdminController

	def index
		@users = User.all
		@users_all = @users.count
		@users_today = @users.where("created_at >= ?", Time.zone.now.beginning_of_day).count
		@message_tot = Message.all.count
		@newcomer_tot = @users.where(local: !true).count
		@users_by_day = @users.group_by_day(:created_at)
		@users_by_month = @users.group_by_month(:created_at)
	end

 
 end
