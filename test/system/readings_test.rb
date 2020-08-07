require "application_system_test_case"

class ReadingsTest < ApplicationSystemTestCase
  setup do
    @reading = readings(:one)
  end

  test "visiting the index" do
    visit readings_url
    assert_selector "h1", text: "Readings"
  end

  test "creating a Reading" do
    visit readings_url
    click_on "New Reading"

    fill_in "Alloy", with: @reading.alloy
    fill_in "Block", with: @reading.block_id
    fill_in "Number", with: @reading.number
    fill_in "Reading at", with: @reading.reading_at
    fill_in "Thickness", with: @reading.thickness
    fill_in "X coordinate", with: @reading.x_coordinate
    fill_in "Y coordinate", with: @reading.y_coordinate
    fill_in "Z coordinate", with: @reading.z_coordinate
    click_on "Create Reading"

    assert_text "Reading was successfully created"
    click_on "Back"
  end

  test "updating a Reading" do
    visit readings_url
    click_on "Edit", match: :first

    fill_in "Alloy", with: @reading.alloy
    fill_in "Block", with: @reading.block_id
    fill_in "Number", with: @reading.number
    fill_in "Reading at", with: @reading.reading_at
    fill_in "Thickness", with: @reading.thickness
    fill_in "X coordinate", with: @reading.x_coordinate
    fill_in "Y coordinate", with: @reading.y_coordinate
    fill_in "Z coordinate", with: @reading.z_coordinate
    click_on "Update Reading"

    assert_text "Reading was successfully updated"
    click_on "Back"
  end

  test "destroying a Reading" do
    visit readings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Reading was successfully destroyed"
  end
end
