require 'test_helper'

class CreateArticleTest < ActionDispatch::IntegrationTest

  setup do
    @user = User.create(username: "bobhope", email: "bob@hope.com", password: "password")
    sign_in_as(@user)
  end

  test "get new article form and create category" do
    get "/articles/new"
    assert_response :success
    assert_difference 'Article.count', 1 do
      post articles_path, params: { article: { title: "Sports I Play",
              description: "I am a big fan of playing basketball.  You could even say it was my favorite sport.",
              category_ids: 1 } }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "get new article form and reject invalid article title" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: " ",
              description: "I am a big fan of playing basketball.  You could even say it was my favorite sport.",
              category_ids: 1 } }
    end
    assert_match "blank", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end

  test "get new article form and reject invalid article body" do
    get "/articles/new"
    assert_response :success
    assert_no_difference 'Article.count' do
      post articles_path, params: { article: { title: "Sports I Play",
              description: " ",
              category_ids: 1 } }
    end
    assert_match "Description is too short", response.body
    assert_select 'div.alert'
    assert_select 'h4.alert-heading'
  end
end
