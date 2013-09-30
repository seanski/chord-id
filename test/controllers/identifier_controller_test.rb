require 'test_helper'

class IdentifierControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show
    assert_response :success
  end

  test "should get identify" do
    get :identify
    assert_response :success
  end

end
