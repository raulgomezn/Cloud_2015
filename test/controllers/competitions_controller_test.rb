require 'test_helper'

class CompetitionsControllerTest < ActionController::TestCase
  setup do
    @competition = competitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:competitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create competition" do
    assert_difference('Competition.count') do
      post :create, competition: { end_date: @competition.end_date, image: @competition.image, name: @competition.name, prize: @competition.prize, start_date: @competition.start_date, url: @competition.url, users_id: @competition.users_id }
    end

    assert_redirected_to competition_path(assigns(:competition))
  end

  test "should show competition" do
    get :show, id: @competition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @competition
    assert_response :success
  end

  test "should update competition" do
    patch :update, id: @competition, competition: { end_date: @competition.end_date, image: @competition.image, name: @competition.name, prize: @competition.prize, start_date: @competition.start_date, url: @competition.url, users_id: @competition.users_id }
    assert_redirected_to competition_path(assigns(:competition))
  end

  test "should destroy competition" do
    assert_difference('Competition.count', -1) do
      delete :destroy, id: @competition
    end

    assert_redirected_to competitions_path
  end
end
