# test/models/user_test.rb
require "test_helper"

class UserTest < ActiveSupport::TestCase
  setup do
    @user_attributes = users(:student).attributes.except("id", "created_at", "updated_at")
  end

  test "require email_address" do
    user = User.new(@user_attributes.merge(email_address: nil))
    assert_not user.valid?, "User should be invalid without email_address"
    assert_includes user.errors[:email_address], "can't be blank"
  end

  test "email_address must be unique" do
    user = User.new(@user_attributes.merge(email_address: users(:student).email_address))
    assert_not user.valid?, "User should be invalid with duplicate email_address"
    assert_includes user.errors[:email_address], "has already been taken"
  end

  test "email_address is normalized" do
    user = User.new(@user_attributes.merge(email_address: "  TEST@Example.COM  "))
    assert user.valid?, "User with valid attributes should be valid"
    user.save
    assert_equal "test@example.com", user.email_address, "Email should be stripped and downcased"
  end

  test "require first_name" do
    user = User.new(@user_attributes.merge(first_name: nil))
    assert_not user.valid?, "User should be invalid without first_name"
    assert_includes user.errors[:first_name], "can't be blank"
  end

  test "require last_name" do
    user = User.new(@user_attributes.merge(last_name: nil))
    assert_not user.valid?, "User should be invalid without last_name"
    assert_includes user.errors[:last_name], "can't be blank"
  end

  test "require account_type" do
    user = User.new(@user_attributes.merge(account_type: nil))
    assert_not user.valid?, "User should be invalid without account_type"
  end

  test "account_type must be valid" do
    user = User.new(@user_attributes.merge(account_type: nil))
    assert_not user.valid?, "User should be invalid with invalid account_type"
  end

  test "require password" do
    user = User.new(@user_attributes.except("password_digest"))
    user.password = nil
    assert_not user.valid?, "User should be invalid without password"
  end
end
