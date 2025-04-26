require "test_helper"

class CustomersControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get customers_upload_url
    assert_response :success
  end
end
