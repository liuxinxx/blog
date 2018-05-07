require 'test_helper'

class DomeControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dome_index_url
    assert_response :success
  end

  test "should get show" do
    get dome_show_url
    assert_response :success
  end

end
