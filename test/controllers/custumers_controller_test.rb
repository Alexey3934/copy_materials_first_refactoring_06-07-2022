require "test_helper"

class CustumersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get custumers_index_url
    assert_response :success
  end
end
