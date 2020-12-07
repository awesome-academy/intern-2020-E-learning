class Admin::CategoriesController < Admin::BaseController
  before_action :get_categories, only: :index
  before_action :get_category, only: %i(edit update destroy)

  def index; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "message.category.create_success"
      redirect_to admin_categories_path
    else
      flash.now[:danger] = t "message.category.create_fail"
      render :new
    end
  end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "message.category.update_success"
      redirect_to session.delete(:back_path) \
        || request.referer || admin_categories_path
    else
      flash.now[:danger] = t "message.category.update_fail"
      render :edit
    end
  end

  def destroy
    @next_category = Category.offset(params[:page].to_i * Settings.per - 1)
                             .first
    if @category.destroy
      flash.now[:success] = t "message.category.delete_success"
    else
      flash.now[:danger] = t "message.category.delete_fail"
    end
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end

  def get_categories
    @categories = Category.by_name(params[:name])
                          .by_description(params[:description])
                          .order_by_created_at
                          .page(params[:page])
                          .per Settings.per
  end

  def get_category
    @category = Category.find_by id: params[:id]
    return if @category

    flash[:danger] = t "message.category.not_found"
    redirect_to admin_categories_path
  end
end
