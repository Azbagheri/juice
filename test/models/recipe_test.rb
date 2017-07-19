require 'test_helper'

class RecipeTest < ActiveSupport::TestCase

  def setup
    @user1 = FactoryGirl.create :user
    2.times{ FactoryGirl.create :recipe, user: @user1}
    # @user2 = FactoryGirl.create :user
  end

  test 'two recipes exist' do
    # FactoryGirl.create :recipe, user: @user
    # FactoryGirl.create :recipe, user: @user
   assert_equal 2, Recipe.all.size
  end

  test 'user1 has created two recipes' do
    assert_equal 2, @user1.recipes.size
  end

end
