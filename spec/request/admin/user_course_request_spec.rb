require "rails_helper"

RSpec.describe Admin::UserCoursesController, type: :controller do
  let(:valid_params) {FactoryBot.attributes_for :user_course, description: "blabla"}
  let(:invalid_params) {FactoryBot.attributes_for :user_course, status: nil}
  let!(:user) {FactoryBot.create :user, role: :admin}
  let!(:normal_user) {FactoryBot.create :user, email: "example@email.com"}
  let!(:course) {FactoryBot.create :course}
  let!(:user_course) {FactoryBot.create :user_course, user: user, course: course}

  before {login user}

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update,
              params: {id: user_course.id,
                       user_course: {status: "finish"}},
              session: {back_path: admin_user_courses_path}}

      it "should correct status" do
        expect(flash[:success]).to eq I18n.t("message.user_course.update_success")
      end
    end

    context "when invalid params" do
      before { patch :update, params: {id: user_course.id, user_course: invalid_params} }

      it "should a invalid user_course" do
        expect(assigns(:user_course).invalid?).to eq true
      end
    end
  end
end
