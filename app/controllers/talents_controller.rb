class TalentsController < ApplicationController
  before_action :authenticate_user!, only: :new

  def index
  end

  def new
  end

  def learn
  end

  def all
  end
end
