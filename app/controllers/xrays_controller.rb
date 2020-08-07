class XraysController < ApplicationController
  before_action :set_xray, only: [:show, :edit, :update, :destroy]

  # GET /xrays
  # GET /xrays.json
  def index
    @xrays = Xray.all
  end

  # GET /xrays/1
  # GET /xrays/1.json
  def show
  end

  # GET /xrays/new
  def new
    @xray = Xray.new
  end

  # GET /xrays/1/edit
  def edit
  end

  # POST /xrays
  # POST /xrays.json
  def create
    @xray = Xray.new(xray_params)

    respond_to do |format|
      if @xray.save
        format.html { redirect_to @xray, notice: 'Xray was successfully created.' }
        format.json { render :show, status: :created, location: @xray }
      else
        format.html { render :new }
        format.json { render json: @xray.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /xrays/1
  # PATCH/PUT /xrays/1.json
  def update
    respond_to do |format|
      if @xray.update(xray_params)
        format.html { redirect_to @xray, notice: 'Xray was successfully updated.' }
        format.json { render :show, status: :ok, location: @xray }
      else
        format.html { render :edit }
        format.json { render json: @xray.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xrays/1
  # DELETE /xrays/1.json
  def destroy
    @xray.destroy
    respond_to do |format|
      format.html { redirect_to xrays_url, notice: 'Xray was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_xray
      @xray = Xray.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def xray_params
      params.require(:xray).permit(:description)
    end
end
