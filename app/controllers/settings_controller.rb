class SettingsController < ApplicationController

  before_action :set_current_user
  
  def profile
  end

  def photo
  end

  def community
  end

  def set_current_user
    @user = current_user
  end
end
