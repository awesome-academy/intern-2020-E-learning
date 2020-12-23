require "rails_helper"

RSpec.describe CourseLecturesController, type: :controller do
  let(:valid_params) {FactoryBot.attributes_for :course_lecture, description: "blabla"}
  let(:invalid_params) {FactoryBot.attributes_for :course_lecture, name: nil}
  let!(:course_lecture) {FactoryBot.create :course_lecture}
  let!(:user) {FactoryBot.create :user, role: :admin}
  let!(:course_lecture_two) {FactoryBot.create :course_lecture}
  let!(:course_lecture_three) {FactoryBot.create :course_lecture}

  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "renders the 'index' template" do
      expect(response).to render_template :index
    end

    it "assigns @course_lectures" do
      expect(assigns(:course_lectures).pluck(:id)).to eq [course_lecture_three.id, course_lecture_two.id, course_lecture.id]
    end
  end

  describe "GET #new" do
    let!(:course_lecture_new) {FactoryBot.create :course_lecture}
    before {get :new}
    it "should render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {course_lecture: valid_params}}

      it "should redirect to admin_course_lectures_path" do
        expect(response).to redirect_to admin_course_lectures_path
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("message.course_lecture.create_success")
      end
    end

    context "when invalid params" do
      before {post :create, params: {course_lecture: invalid_params}}

      it "should return danger message" do
        expect(flash[:danger]).to eq I18n.t("message.course_lecture.create_fail")
      end
    end
  end

  describe "GET #edit" do
    context "when valid params" do
      before {get :edit, params: {id: course_lecture.id}}

      it "should have a valid course_lecture" do
        expect(assigns(:course_lecture).id).to eq course_lecture.id
      end
    end

    context "when invalid params" do
      before {get :edit, params: {id: "string"}}

      it "should have a invalid course_lecture" do
        expect(assigns(:course_lecture)).to eq nil
      end
    end
  end

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update, params: {id: course_lecture.id, course_lecture: {name: "Test update"}}}

      it "should correct name" do
        expect(assigns(:course_lecture).name).to eq "Test update"
      end

      it "should redirect admin_course_lectures_path" do
        expect(response).to redirect_to admin_course_lectures_path
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: course_lecture.id, course_lecture: invalid_params} }

      it "should a invalid course_lecture" do
        expect(assigns(:course_lecture).invalid?).to eq true
      end

      it "should render edit template" do
        expect(response).to render_template :edit
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before { delete :destroy, params: {id: course_lecture.id, page: 2} }

      it "should return true" do
        expect(assigns(:course_lecture).destroyed?).to eq true
      end

      it "should return success message" do
        expect(flash[:success]).to eq I18n.t("message.course_lecture.delete_success")
      end
    end

    context "when invalid params" do
      before {delete :destroy, params: {id: "abc"}}

      it "should return danger message" do
        expect(flash[:danger]).to eq I18n.t("message.course_lecture.not_found")
      end

      it "should redirect to :index" do
        expect(response).to redirect_to admin_course_lectures_path
      end
    end

    context "when destroy fail" do
      before do
        allow_any_instance_of(course_lecture).to receive(:destroy).and_return false
        delete :destroy, params: {id: course_lecture.id, page: 2}
      end

      it "should return danger message" do
        expect(flash[:danger]).to eq I18n.t("message.course_lecture.delete_fail")
      end

      it "should redirect to admin_course_lectures_path" do
        expect(response).to redirect_to admin_course_lectures_path
      end
    end
  end
end
