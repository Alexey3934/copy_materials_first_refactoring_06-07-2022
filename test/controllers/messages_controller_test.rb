require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get add" do
    get messages_add_url
    assert_response :success
  end

  test "should get delete" do
    get messages_delete_url
    assert_response :success
  end
end
