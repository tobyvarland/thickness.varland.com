require 'test_helper'

class XraysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @xray = xrays(:one)
  end

  test "should get index" do
    get xrays_url
    assert_response :success
  end

  test "should get new" do
    get new_xray_url
    assert_response :success
  end

  test "should create xray" do
    assert_difference('Xray.count') do
      post xrays_url, params: { xray: { description: @xray.description } }
    end

    assert_redirected_to xray_url(Xray.last)
  end

  test "should show xray" do
    get xray_url(@xray)
    assert_response :success
  end

  test "should get edit" do
    get edit_xray_url(@xray)
    assert_response :success
  end

  test "should update xray" do
    patch xray_url(@xray), params: { xray: { description: @xray.description } }
    assert_redirected_to xray_url(@xray)
  end

  test "should destroy xray" do
    assert_difference('Xray.count', -1) do
      delete xray_url(@xray)
    end

    assert_redirected_to xrays_url
  end
end
