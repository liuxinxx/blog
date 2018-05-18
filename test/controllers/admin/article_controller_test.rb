require 'test_helper'

class Admin::ArticleControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_article_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_article_show_url
    assert_response :success
  end

end
