require 'test_helper'

class NetworkInterfaceTypesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:network_interface_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create network_interface_type" do
    assert_difference('NetworkInterfaceType.count') do
      post :create, :network_interface_type => { }
    end

    assert_redirected_to network_interface_type_path(assigns(:network_interface_type))
  end

  test "should show network_interface_type" do
    get :show, :id => network_interface_types(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => network_interface_types(:one).to_param
    assert_response :success
  end

  test "should update network_interface_type" do
    put :update, :id => network_interface_types(:one).to_param, :network_interface_type => { }
    assert_redirected_to network_interface_type_path(assigns(:network_interface_type))
  end

  test "should destroy network_interface_type" do
    assert_difference('NetworkInterfaceType.count', -1) do
      delete :destroy, :id => network_interface_types(:one).to_param
    end

    assert_redirected_to network_interface_types_path
  end
end
