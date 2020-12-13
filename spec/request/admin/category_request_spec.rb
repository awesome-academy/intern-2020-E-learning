require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:valid_params) {FactoryBot.attributes_for :category, description: "description"}
  let(:invalid_params) {FactoryBot.attributes_for :category, name: nil}
  let!(:category) {FactoryBot.create :category}
  let!(:user) {FactoryBot.create :user, role: :admin}
  let!(:category_two) {FactoryBot.create :category}
  let!(:category_three) {FactoryBot.create :category}

  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "renders the 'index' template" do
      expect(response).to render_template :index
    end

    it "assigns @categories" do
      expect(assigns(:categories).pluck(:id)).to eq [category_three.id, category_two.id, category.id]
    end
  end

  describe "GET #new" do
    let!(:category_new) {FactoryBot.create :category}
    before {get :new}
    it "should render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {category: valid_params}}

      it "should redirect to admin_categories_path" do
        expect(response).to redirect_to admin_categories_path
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("message.category.create_success")
      end
    end

    context "when invalid params" do
      before {post :create, params: {category: invalid_params}}

      it "should return danger message" do
        expect(flash[:danger]).to eq I18n.t("message.category.create_fail")
      end
    end
  end

  describe "GET #edit" do
    context "when valid params" do
      before {get :edit, params: {id: category.id}}

      it "should have a valid category" do
        expect(assigns(:category).id).to eq category.id
      end
    end

    context "when invalid params" do
      before {get :edit, params: {id: "string"}}

      it "should have a invalid category" do
        expect(assigns(:category)).to eq nil
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: category.id, category: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:category).name).to eq "Test update"
      end

      it "should redirect admin_categories_path" do
        expect(response).to redirect_to admin_categories_path
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: category.id, category: invalid_params} }

      it "should a invalid category" do
        expect(assigns(:category).invalid?).to eq true
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before { delete :destroy, params: {id: category.id, page: 2} }

      it "should return true" do
        expect(assigns(:category).destroyed?).to eq true
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("message.category.delete_success")
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should return danger message" do
        expect(flash[:danger]).to eq I18n.t("message.category.not_found")
      end

      it "should redirect to :index" do
        expect(response).to redirect_to admin_categories_path
      end
    end

    context "when destroy fail" do
      before do
        allow_any_instance_of(Category).to receive(:destroy).and_return false
        delete :destroy, params: {id: category.id, page: 2}
      end

      it "should return danger message" do
        expect(flash[:danger]).to eq I18n.t("message.category.delete_fail")
      end

      it "should redirect to admin_categories_path" do
        expect(response).to redirect_to admin_categories_path
      end
    end
  end
end
