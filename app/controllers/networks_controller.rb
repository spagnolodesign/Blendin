class NetworksController < ApplicationController
  before_action :set_network, only: [:show, :edit, :update, :destroy]

  def index
    # redirect_to action: "new"
  end

  def new
    @network = Network.new
  end


  def end_submit
  end

  def create
    @network = Network.new(network_params)

    respond_to do |format|
      if @network.save
        format.html { render :end_submit, notice: "" }
      else
        format.html { render :new }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network
      @network = Network.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_params
      params.require(:network).permit(:name, :sector, :network, :city, :email, :residence, :phone, :gender, :birthday, :about)
    end
end
