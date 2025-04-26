require "test_helper"

class TopicsControllerTest < ActionDispatch::IntegrationTest
  setup do
    # @admin_topic = admin_topics(:one)
  end

  test "should get index" do
    get admin_topics_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_topic_url
    assert_response :success
  end

  # test "should create admin_topic" do
  #   assert_difference("Topic.count") do
  #     post admin_topics_url, params: { admin_topic: {} }
  #   end
  #
  #   assert_redirected_to admin_topic_url(Topic.last)
  # end

  # test "should show admin_topic" do
  #   get admin_topic_url(@admin_topic)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_admin_topic_url(@admin_topic)
  #   assert_response :success
  # end
  #
  # test "should update admin_topic" do
  #   patch admin_topic_url(@admin_topic), params: { admin_topic: {} }
  #   assert_redirected_to admin_topic_url(@admin_topic)
  # end

  # test "should destroy admin_topic" do
  #   assert_difference("Topic.count", -1) do
  #     delete admin_topic_url(@admin_topic)
  #   end
  #
  #   assert_redirected_to admin_topics_url
  # end
end
