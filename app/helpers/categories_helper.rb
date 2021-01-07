module CategoriesHelper
  def categories
    Category.all
            .pluck(:name, :id)
  end
end
