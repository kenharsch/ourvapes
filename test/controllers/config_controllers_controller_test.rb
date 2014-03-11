require 'test_helper'

class ConfigControllersControllerTest < ActionController::TestCase
  setup do
    @config_controller = config_controllers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:config_controllers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create config_controller" do
    assert_difference('ConfigController.count') do
      post :create, config_controller: { show: @config_controller.show }
    end

    assert_redirected_to config_controller_path(assigns(:config_controller))
  end

  test "should show config_controller" do
    get :show, id: @config_controller
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @config_controller
    assert_response :success
  end

  test "should update config_controller" do
    patch :update, id: @config_controller, config_controller: { show: @config_controller.show }
    assert_redirected_to config_controller_path(assigns(:config_controller))
  end

  test "should destroy config_controller" do
    assert_difference('ConfigController.count', -1) do
      delete :destroy, id: @config_controller
    end

    assert_redirected_to config_controllers_path
  end
end
