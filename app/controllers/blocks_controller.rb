class BlocksController < ApplicationController

  # Use has_scope gem for filtering.
  has_scope :sorted_by, only: :index
  has_scope :on_or_after, only: :index
  has_scope :on_or_before, only: :index
  has_scope :with_shop_order, only: :index
  has_scope :with_load, only: :index
  has_scope :with_rework, only: :index
  has_scope :with_early, only: :index
  has_scope :with_strip, only: :index
  has_scope :with_customer, only: :index
  has_scope :with_process, only: :index
  has_scope :with_part, only: :index
  has_scope :with_sub, only: :index
  has_scope :with_part_name, only: :index
  has_scope :with_xray, only: :index
  has_scope :with_application, only: :index
  has_scope :with_directory, only: :index
  has_scope :with_product, only: :index
  has_scope :with_operator, only: :index
  has_scope :with_mean_thickness, only: :index
  has_scope :with_min_thickness, only: :index
  has_scope :with_max_thickness, only: :index
  has_scope :with_std_dev_thickness, only: :index
  has_scope :with_mean_alloy, only: :index
  has_scope :with_min_alloy, only: :index
  has_scope :with_max_alloy, only: :index
  has_scope :with_std_dev_alloy, only: :index

  before_action :set_block, only: [:show, :edit, :update, :destroy]

  # GET /blocks
  # GET /blocks.json
  def index
    filters_to_cookies(all_filters)
    @thickness_user = current_user
    params[:per_page] = 50 if params[:per_page].blank?
    params[:sorted_by] = 'newest' if params[:sorted_by].blank?
    params[:show_statistics] = 'no' if params[:show_statistics].blank?
    count_filters
    @unpaged_blocks = apply_scopes(Block.includes(:user, :readings))
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

  def reset_filters
    filters_to_cookies(all_filters, reset: true)
    redirect_to root_url
  end

  def reset_filter
    filters_to_cookies([params[:filter]], reset: true)
    redirect_to root_url
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
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private

    def count_filters
      @count_filters = 0
      @count_filters += 1 unless params[:per_page].to_i == 50
      @count_filters += 1 unless params[:sorted_by] == 'newest'
      @count_filters += 1 unless params[:show_statistics] == 'no'
      @count_filters += 1 unless params[:on_or_after].blank?
      @count_filters += 1 unless params[:on_or_before].blank?
      @count_filters += 1 unless params[:with_shop_order].blank?
      @count_filters += 1 unless params[:with_load].blank?
      @count_filters += 1 unless params[:with_rework].blank?
      @count_filters += 1 unless params[:with_early].blank?
      @count_filters += 1 unless params[:with_strip].blank?
      @count_filters += 1 unless params[:with_customer].blank?
      @count_filters += 1 unless params[:with_process].blank?
      @count_filters += 1 unless params[:with_part].blank?
      @count_filters += 1 unless params[:with_sub].blank?
      @count_filters += 1 unless params[:with_part_name].blank?
      @count_filters += 1 unless params[:with_xray].blank?
      @count_filters += 1 unless params[:with_application].blank?
      @count_filters += 1 unless params[:with_directory].blank?
      @count_filters += 1 unless params[:with_product].blank?
      @count_filters += 1 unless params[:with_operator].blank?
      @count_filters += 1 unless params[:with_mean_thickness].blank?
      @count_filters += 1 unless params[:with_min_thickness].blank?
      @count_filters += 1 unless params[:with_max_thickness].blank?
      @count_filters += 1 unless params[:with_std_dev_thickness].blank?
      @count_filters += 1 unless params[:with_mean_alloy].blank?
      @count_filters += 1 unless params[:with_min_alloy].blank?
      @count_filters += 1 unless params[:with_max_alloy].blank?
      @count_filters += 1 unless params[:with_std_dev_alloy].blank?
      @count_filters += 1 unless params[:page].blank?
    end

    def all_filters
      [
        :on_or_after,
        :on_or_before,
        :sorted_by,
        :per_page,
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
        :show_statistics,
        :page
      ]
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_block
      @block = Block.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def block_params
      params.require(:block).permit(:xray_id, :user_id, :directory, :product, :application, :block_at, :number, :shop_order, :load, :is_early, :is_rework, :is_strip, :customer_code, :process_code, :part_number, :part_sub, :part_control, :part_name_1, :part_name_2, :part_name_3, :count_readings, :has_alloy, :mean_thickness, :min_thickness, :max_thickness, :std_dev_thickness, :mean_alloy, :min_alloy, :max_alloy, :std_dev_alloy)
    end
end
