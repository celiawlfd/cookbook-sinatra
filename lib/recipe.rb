class Recipe
  attr_reader :name, :description, :rating, :time

  def initialize(attributes = {})
    @name = attributes[:name]
    @description = attributes[:description]
    @rating = attributes[:rating]
    @done = attributes[:done] == "true"
    @time = attributes[:time]
  end

  def done?
    @done
  end

  def mark_as_done!
    @done = true
  end
end
