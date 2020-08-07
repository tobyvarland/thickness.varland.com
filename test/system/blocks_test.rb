require "application_system_test_case"

class BlocksTest < ApplicationSystemTestCase
  setup do
    @block = blocks(:one)
  end

  test "visiting the index" do
    visit blocks_url
    assert_selector "h1", text: "Blocks"
  end

  test "creating a Block" do
    visit blocks_url
    click_on "New Block"

    fill_in "Application", with: @block.application
    fill_in "Block at", with: @block.block_at
    fill_in "Count readings", with: @block.count_readings
    fill_in "Customer code", with: @block.customer_code
    fill_in "Directory", with: @block.directory
    check "Has alloy" if @block.has_alloy
    check "Is early" if @block.is_early
    check "Is rework" if @block.is_rework
    check "Is strip" if @block.is_strip
    fill_in "Load", with: @block.load
    fill_in "Max alloy", with: @block.max_alloy
    fill_in "Max thickness", with: @block.max_thickness
    fill_in "Mean alloy", with: @block.mean_alloy
    fill_in "Mean thickness", with: @block.mean_thickness
    fill_in "Min alloy", with: @block.min_alloy
    fill_in "Min thickness", with: @block.min_thickness
    fill_in "Number", with: @block.number
    fill_in "Part control", with: @block.part_control
    fill_in "Part name 1", with: @block.part_name_1
    fill_in "Part name 2", with: @block.part_name_2
    fill_in "Part name 3", with: @block.part_name_3
    fill_in "Part number", with: @block.part_number
    fill_in "Part sub", with: @block.part_sub
    fill_in "Process code", with: @block.process_code
    fill_in "Product", with: @block.product
    fill_in "Shop order", with: @block.shop_order
    fill_in "Std dev alloy", with: @block.std_dev_alloy
    fill_in "Std dev thickness", with: @block.std_dev_thickness
    fill_in "User", with: @block.user_id
    fill_in "Xray", with: @block.xray_id
    click_on "Create Block"

    assert_text "Block was successfully created"
    click_on "Back"
  end

  test "updating a Block" do
    visit blocks_url
    click_on "Edit", match: :first

    fill_in "Application", with: @block.application
    fill_in "Block at", with: @block.block_at
    fill_in "Count readings", with: @block.count_readings
    fill_in "Customer code", with: @block.customer_code
    fill_in "Directory", with: @block.directory
    check "Has alloy" if @block.has_alloy
    check "Is early" if @block.is_early
    check "Is rework" if @block.is_rework
    check "Is strip" if @block.is_strip
    fill_in "Load", with: @block.load
    fill_in "Max alloy", with: @block.max_alloy
    fill_in "Max thickness", with: @block.max_thickness
    fill_in "Mean alloy", with: @block.mean_alloy
    fill_in "Mean thickness", with: @block.mean_thickness
    fill_in "Min alloy", with: @block.min_alloy
    fill_in "Min thickness", with: @block.min_thickness
    fill_in "Number", with: @block.number
    fill_in "Part control", with: @block.part_control
    fill_in "Part name 1", with: @block.part_name_1
    fill_in "Part name 2", with: @block.part_name_2
    fill_in "Part name 3", with: @block.part_name_3
    fill_in "Part number", with: @block.part_number
    fill_in "Part sub", with: @block.part_sub
    fill_in "Process code", with: @block.process_code
    fill_in "Product", with: @block.product
    fill_in "Shop order", with: @block.shop_order
    fill_in "Std dev alloy", with: @block.std_dev_alloy
    fill_in "Std dev thickness", with: @block.std_dev_thickness
    fill_in "User", with: @block.user_id
    fill_in "Xray", with: @block.xray_id
    click_on "Update Block"

    assert_text "Block was successfully updated"
    click_on "Back"
  end

  test "destroying a Block" do
    visit blocks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Block was successfully destroyed"
  end
end
