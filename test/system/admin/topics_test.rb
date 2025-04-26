require "application_system_test_case"

class Admin::TopicsTest < ApplicationSystemTestCase
  setup do
    @admin_topic = admin_topics(:one)
  end

  test "visiting the index" do
    visit admin_topics_url
    assert_selector "h1", text: "Topics"
  end

  test "should create topic" do
    visit admin_topics_url
    click_on "New topic"

    click_on "Create Topic"

    assert_text "Topic was successfully created"
    click_on "Back"
  end

  test "should update Topic" do
    visit admin_topic_url(@admin_topic)
    click_on "Edit this topic", match: :first

    click_on "Update Topic"

    assert_text "Topic was successfully updated"
    click_on "Back"
  end

  test "should destroy Topic" do
    visit admin_topic_url(@admin_topic)
    click_on "Destroy this topic", match: :first

    assert_text "Topic was successfully destroyed"
  end
end
