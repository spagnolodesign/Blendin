namespace :blend do
  desc "BLEND TASK"

  task match_opportunity: :environment do
    @users = User.all

    @users.each do |user|
      @mightmatch = User.all.near([user.latitude, user.longitude], 7).where(local: !user.local).tagged_with(user.tags, :any => true).for_age_range(user.age - 2, user.age + 2).where.not(id: user.id).order(created_at: :desc)
      @possible_candidate = @mightmatch[rand(0...@mightmatch.size)]

      unless (!user.match?(@possible_candidate))
          puts "Send blend"
      else
          puts "NO"
      end

    end

  end

end
