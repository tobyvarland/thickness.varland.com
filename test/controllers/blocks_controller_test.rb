require 'test_helper'

class BlocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @block = blocks(:one)
  end

  test "should get index" do
    get blocks_url
    assert_response :success
  end

  test "should get new" do
    get new_block_url
    assert_response :success
  end

  test "should create block" do
    assert_difference('Block.count') do
      post blocks_url, params: { block: { application: @block.application, block_at: @block.block_at, count_readings: @block.count_readings, customer_code: @block.customer_code, directory: @block.directory, has_alloy: @block.has_alloy, is_early: @block.is_early, is_rework: @block.is_rework, is_strip: @block.is_strip, load: @block.load, max_alloy: @block.max_alloy, max_thickness: @block.max_thickness, mean_alloy: @block.mean_alloy, mean_thickness: @block.mean_thickness, min_alloy: @block.min_alloy, min_thickness: @block.min_thickness, number: @block.number, part_control: @block.part_control, part_name_1: @block.part_name_1, part_name_2: @block.part_name_2, part_name_3: @block.part_name_3, part_number: @block.part_number, part_sub: @block.part_sub, process_code: @block.process_code, product: @block.product, shop_order: @block.shop_order, std_dev_alloy: @block.std_dev_alloy, std_dev_thickness: @block.std_dev_thickness, user_id: @block.user_id, xray_id: @block.xray_id } }
    end

    assert_redirected_to block_url(Block.last)
  end

  test "should show block" do
    get block_url(@block)
    assert_response :success
  end

  test "should get edit" do
    get edit_block_url(@block)
    assert_response :success
  end

  test "should update block" do
    patch block_url(@block), params: { block: { application: @block.application, block_at: @block.block_at, count_readings: @block.count_readings, customer_code: @block.customer_code, directory: @block.directory, has_alloy: @block.has_alloy, is_early: @block.is_early, is_rework: @block.is_rework, is_strip: @block.is_strip, load: @block.load, max_alloy: @block.max_alloy, max_thickness: @block.max_thickness, mean_alloy: @block.mean_alloy, mean_thickness: @block.mean_thickness, min_alloy: @block.min_alloy, min_thickness: @block.min_thickness, number: @block.number, part_control: @block.part_control, part_name_1: @block.part_name_1, part_name_2: @block.part_name_2, part_name_3: @block.part_name_3, part_number: @block.part_number, part_sub: @block.part_sub, process_code: @block.process_code, product: @block.product, shop_order: @block.shop_order, std_dev_alloy: @block.std_dev_alloy, std_dev_thickness: @block.std_dev_thickness, user_id: @block.user_id, xray_id: @block.xray_id } }
    assert_redirected_to block_url(@block)
  end

  test "should destroy block" do
    assert_difference('Block.count', -1) do
      delete block_url(@block)
    end

    assert_redirected_to blocks_url
  end
end
