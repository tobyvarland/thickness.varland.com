class BlocksController < ApplicationController

  # Use has_scope gem for filtering.
  has_scope :sorted_by
  has_scope :on_or_after
  has_scope :on_or_before
  has_scope :with_shop_order
  has_scope :with_load
  has_scope :with_rework
  has_scope :with_early
  has_scope :with_strip
  has_scope :with_customer
  has_scope :with_process
  has_scope :with_part
  has_scope :with_sub
  has_scope :with_part_name
  has_scope :with_xray
  has_scope :with_application
  has_scope :with_directory
  has_scope :with_product
  has_scope :with_operator
  has_scope :with_mean_thickness
  has_scope :with_min_thickness
  has_scope :with_max_thickness
  has_scope :with_std_dev_thickness
  has_scope :with_mean_alloy
  has_scope :with_min_alloy
  has_scope :with_max_alloy
  has_scope :with_std_dev_alloy

  before_action :set_block, only: [:show, :edit, :update, :destroy]

  def reset_filters
    filters_to_cookies([:per_page,
                        :sorted_by,
                        :with_shop_order,
                        :with_load,
                        :with_rework,
                        :with_early,
                        :with_strip,
                        :with_customer,
                        :with_process,
                        :with_part,
                        :with_sub,
                        :with_part_name,
                        :with_xray,
                        :with_application,
                        :with_directory,
                        :with_product,
                        :with_operator,
                        :with_mean_thickness,
                        :with_min_thickness,
                        :with_max_thickness,
                        :with_std_dev_thickness,
                        :with_mean_alloy,
                        :with_min_alloy,
                        :with_max_alloy,
                        :with_std_dev_alloy,
                        :on_or_after,
                        :on_or_before], reset: true)
    redirect_to blocks_path
  end

  # GET /blocks
  # GET /blocks.json
  def index
    filters_to_cookies([:per_page,
                        :sorted_by,
                        :with_shop_order,
                        :with_load,
                        :with_rework,
                        :with_early,
                        :with_strip,
                        :with_customer,
                        :with_process,
                        :with_part,
                        :with_sub,
                        :with_part_name,
                        :with_xray,
                        :with_application,
                        :with_directory,
                        :with_product,
                        :with_operator,
                        :with_mean_thickness,
                        :with_min_thickness,
                        :with_max_thickness,
                        :with_std_dev_thickness,
                        :with_mean_alloy,
                        :with_min_alloy,
                        :with_max_alloy,
                        :with_std_dev_alloy,
                        :on_or_after,
                        :on_or_before])
    params[:per_page] = 50 if params[:per_page].blank?
    params[:sorted_by] = 'newest' if params[:sorted_by].blank?
    @unpaged_blocks = apply_scopes(Block.includes(:user, :xray, :readings))
    begin
      @pagy, @blocks = pagy(@unpaged_blocks, items: params[:per_page])
    rescue
      @pagy, @blocks = pagy(@unpaged_blocks, items: params[:per_page], page: 1)
    end
    respond_to do |format|
      format.html
      format.xlsx {
        timestamp = DateTime.current.strftime("%Y%m%d_%H%M%S")
        response.headers['Content-Disposition'] = "attachment; filename=\"ThicknessExport_#{timestamp}.xlsx\""
      }
    end
  end

  # GET /blocks/1
  # GET /blocks/1.json
  def show
  end

  # GET /blocks/new
  def new
    @block = Block.new
  end

  # GET /blocks/1/edit
  def edit
  end

  # POST /blocks
  # POST /blocks.json
  def create
    @block = Block.new(block_params)

    respond_to do |format|
      if @block.save
        format.html { redirect_to @block, notice: 'Block was successfully created.' }
        format.json { render :show, status: :created, location: @block }
      else
        format.html { render :new }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /blocks/1
  # PATCH/PUT /blocks/1.json
  def update
    respond_to do |format|
      if @block.update(block_params)
        format.html { redirect_to @block, notice: 'Block was successfully updated.' }
        format.json { render :show, status: :ok, location: @block }
      else
        format.html { render :edit }
        format.json { render json: @block.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /blocks/1
  # DELETE /blocks/1.json
  def destroy
    @block.destroy
    respond_to do |format|
      format.html { redirect_to blocks_url, notice: 'Block was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def block_params
      params.require(:block).permit(:xray_id, :user_id, :directory, :product, :application, :block_at, :number, :shop_order, :load, :is_early, :is_rework, :is_strip, :customer_code, :process_code, :part_number, :part_sub, :part_control, :part_name_1, :part_name_2, :part_name_3, :count_readings, :has_alloy, :mean_thickness, :min_thickness, :max_thickness, :std_dev_thickness, :mean_alloy, :min_alloy, :max_alloy, :std_dev_alloy)
    end
end
