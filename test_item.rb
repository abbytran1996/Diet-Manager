# Test Basic Food, Recipe,
# Abigail My Tran
# December 3rd, 2016

require 'test/unit'
require './BasicFood'
require './Recipe'
require './LogItem'

class TestDietManager < Test::Unit::TestCase
  #def setup
  #end

  # def teardown
  # end

  def test_BasicFood
    food = BasicFood.new('Chocolate', 200)
    assert( food.calories == 200, 'Failure in BasicFood calorie accessor' )
    assert( food.name == 'Chocolate', 'Failure in BasicFood name accessor' )
    assert( food.name == 'wrongname', 'This test should fail because the food.name is: ' + food.name )
  end

  def test_Recipe
    recipe = Recipe.new('Chicken Salad', ['Salad', 'Dill Carrot', 'Fish Sauce'] )

    assert( recipe.name == 'Chicken Salad', 'Failure in Recipe name accessor' )
    assert( recipe.ingredients == ['Salad', 'Dill Carrot', 'Fish Sauce'], 'Failure in Recipe ingredients accessor' )
    assert( recipe.ingredients[1] == 'Dill Carrot', 'Failure in parsing in ingredients' )
  end

  def test_LogItem
    item = LogItem.new('Noodle', 2)
    assert( item.name == 'Noodle', 'Failure in LogItem name accessor' )
    assert( item.occur == 2, 'Failure in LogItem occur accessor' )
  end

end

