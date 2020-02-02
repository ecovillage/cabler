class Devices::LinksController < ApplicationController
  before_action :set_device#, only: [:show, :edit, :update, :destroy]#, :create, :new]
  before_action :set_link, only: [:show, :edit, :update, :destroy]

  # GET /device/1/links
  # GET /device/1/links.json
  def index
    @links = Link.all
  end

  # GET /links/1
  # GET /links/1.json
  def show
  end

  # GET /links/new
  def new
    @link = @device.links.build
  end

  # GET /links/1/edit
  def edit
  end

  # POST /links
  # POST /links.json
  def create
    @link = @device.link_one_ends.build(link_params)
    if params.dig(:link, :other_end_device_id).present?
      @link.other_end = Device.find params.dig(:link, :other_end_device_id)
    end
    #@link = Link.new(link_params)

    respond_to do |format|
      if @link.save
        format.html { redirect_to @device, notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1
  # PATCH/PUT /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        format.html { redirect_to @device, notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1
  # DELETE /links/1.json
  def destroy
    @link.destroy
    respond_to do |format|
      format.html { redirect_to device_url(@device), notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_link
      @link = Link.find(params[:id])
    end

    def set_device
      @device = Device.find(params[:device_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def link_params
      params.require(:link).permit(:device_id, :name, :other_end_id, :one_end_id, :slot_other_end, :slot_one_end, :kind)
    end
end
