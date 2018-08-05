class TalentsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def new
  end

  def learn
  end

  def show
    @talent = Talent.find(params[:id])
  end

  def contact
    @message = params[:talents][:message]
    @talent = Talent.find(params[:talent_id])
    TalentMailer.contact_talent(current_user, @talent, @message).deliver
    redirect_to talent_path(@talent), notice: "We've sent your request the host will contact you directly."
  end

  def all
    @talents = Talent.all.order(:created_at)
  end
end
