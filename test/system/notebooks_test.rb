require "application_system_test_case"

class NotebooksTest < ApplicationSystemTestCase
  setup do
    @notebook = notebooks(:one)
  end

  test "visiting the index" do
    visit notebooks_url
    assert_selector "h1", text: "Notebooks"
  end

  test "should create notebook" do
    visit notebooks_url
    click_on "New notebook"

    click_on "Create Notebook"

    assert_text "Notebook was successfully created"
    click_on "Back"
  end

  test "should update Notebook" do
    visit notebook_url(@notebook)
    click_on "Edit this notebook", match: :first

    click_on "Update Notebook"

    assert_text "Notebook was successfully updated"
    click_on "Back"
  end

  test "should destroy Notebook" do
    visit notebook_url(@notebook)
    click_on "Destroy this notebook", match: :first

    assert_text "Notebook was successfully destroyed"
  end
end
