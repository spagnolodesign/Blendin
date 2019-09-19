require 'test_helper'

class NetworkApplicationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @network_application = network_applications(:one)
  end

  test "should get index" do
    get network_applications_url
    assert_response :success
  end

  test "should get new" do
    get new_network_application_url
    assert_response :success
  end

  test "should create network_application" do
    assert_difference('NetworkApplication.count') do
      post network_applications_url, params: { network_application: { city: @network_application.city, email: @network_application.email, name: @network_application.name, network: @network_application.network, sector: @network_application.sector } }
    end

    assert_redirected_to network_application_url(NetworkApplication.last)
  end

  test "should show network_application" do
    get network_application_url(@network_application)
    assert_response :success
  end

  test "should get edit" do
    get edit_network_application_url(@network_application)
    assert_response :success
  end

  test "should update network_application" do
    patch network_application_url(@network_application), params: { network_application: { city: @network_application.city, email: @network_application.email, name: @network_application.name, network: @network_application.network, sector: @network_application.sector } }
    assert_redirected_to network_application_url(@network_application)
  end

  test "should destroy network_application" do
    assert_difference('NetworkApplication.count', -1) do
      delete network_application_url(@network_application)
    end

    assert_redirected_to network_applications_url
  end
end
