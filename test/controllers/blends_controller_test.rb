require 'test_helper'

class BlendsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get blends_create_url
    assert_response :success
  end

end
