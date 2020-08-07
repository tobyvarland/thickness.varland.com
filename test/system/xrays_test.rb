require "application_system_test_case"

class XraysTest < ApplicationSystemTestCase
  setup do
    @xray = xrays(:one)
  end

  test "visiting the index" do
    visit xrays_url
    assert_selector "h1", text: "Xrays"
  end

  test "creating a Xray" do
    visit xrays_url
    click_on "New Xray"

    fill_in "Description", with: @xray.description
    click_on "Create Xray"

    assert_text "Xray was successfully created"
    click_on "Back"
  end

  test "updating a Xray" do
    visit xrays_url
    click_on "Edit", match: :first

    fill_in "Description", with: @xray.description
    click_on "Update Xray"

    assert_text "Xray was successfully updated"
    click_on "Back"
  end

  test "destroying a Xray" do
    visit xrays_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Xray was successfully destroyed"
  end
end
