require "csv"
require_relative "recipe"

class Cookbook
  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @recipes = []
    load_csv
  end

  def all
    @recipes
  end

  def create(recipe)
    @recipes << recipe
    save_csv
  end

  def destroy(recipe_index)
    @recipes.delete_at(recipe_index)
    save_csv
  end

  def mark_as_done(index)
    @recipes[index].mark_as_done!
    save_csv
  end

  private

  def load_csv
    # Parsing --> loading
    CSV.foreach(@csv_file_path) do |row| #CSV need to be upcase
      # Here, row is an array of columns
      @recipes <<Recipe.new(
        name: row[0],
        description: row[1],
        rating: row[2],
        done: row[3],
        time: row[4]
      )
      # we will get the first name, laste name and instrument
    end
  end

  def save_csv
    # Storing -> saving
      # r - read-only
      # wb - write binary (it's going to overwrite the file)
      # ab - to add
    CSV.open(@csv_file_path, "wb") do |csv| # convention we call it csv
      @recipes.each do |recipe|
        csv << [recipe.name, recipe.description, recipe.rating, recipe.done?, recipe.time]
      end
    end
  end
end
