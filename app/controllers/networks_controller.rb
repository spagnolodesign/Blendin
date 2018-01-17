class NetworksController < ApplicationController
  before_action :set_network, only: [:show, :edit, :update, :destroy]

  def index
    redirect_to action: "new"
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
        format.json { render :show, status: :created, location: @network }
      else
        format.html { render :new }
        format.json { render json: @network.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /network_applications/1
  # PATCH/PUT /network_applications/1.json
  # def update
  #   respond_to do |format|
  #     if @network.update(network_params)
  #       format.html { redirect_to @network, notice: 'Network application was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @network }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @network.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /network_applications/1
  # DELETE /network_applications/1.json
  # def destroy
  #   @network.destroy
  #   respond_to do |format|
  #     format.html { redirect_to network_applications_url, notice: 'Network application was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_network
      @network = Network.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def network_params
      params.require(:network).permit(:name, :sector, :network, :city, :email)
    end
end
