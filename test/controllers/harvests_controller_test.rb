require 'test_helper'

class HarvestsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get harvests_index_url
    assert_response :success
  end

  test "should get show" do
    get harvests_show_url
    assert_response :success
  end

  test "should get new" do
    get harvests_new_url
    assert_response :success
  end

  test "should get create" do
    get harvests_create_url
    assert_response :success
  end

end
