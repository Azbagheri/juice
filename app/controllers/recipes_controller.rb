class RecipesController < ApplicationController
  before_action :require_login, only: [:new, :show]

  def new
    @recipe = Recipe.new
    @recipe.ingredients.build
    @recipe.ingredients_recipes.build
  end

  def index
      if ( params[ :query ] && params[ :query ] != "" )
        queryArr = params[ :query ].split( " " )

        allResults = [];

        queryArr.each do | queryTerm |
          results = Recipe.joins( :ingredients ).where( "recipes.name LIKE ? OR ingredients.name LIKE ?",  "%#{queryTerm}%".titlecase, "%#{queryTerm}%".upcase )

          allResults = allResults.concat( results )
        end
        @recipes = allResults.uniq
      else
        @recipes = Recipe.all
      end

  end

  def show
    @recipe = Recipe.find(params[:id])
    if current_user
      @review = @recipe.reviews.build
    end
  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user_id = current_user.id

    if @recipe.save
      @recipe.generate_name
      redirect_to recipe_path(@recipe)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])

    if @recipe.update(recipe_params)
      redirect_to recipe_url(@recipe)
    else
      # redirect_back_or_t edit_recipe_path(@recipe)
      render :edit
    end
  end

private
  def recipe_params
    params.require(:recipe).permit(:name, :image, :user_id, ingredients_recipes_attributes: [:ingredient_id, :quantity, :unit_id, :id, :_destroy])

  end

end
