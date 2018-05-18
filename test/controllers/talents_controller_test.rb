require 'test_helper'

class TalentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get talents_index_url
    assert_response :success
  end

  test "should get new" do
    get talents_new_url
    assert_response :success
  end

end
