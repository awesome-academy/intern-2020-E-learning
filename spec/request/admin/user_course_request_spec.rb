require "rails_helper"

RSpec.describe Admin::UserCoursesController, type: :controller do
  let!(:user) {FactoryBot.create :user, role: :admin}
  let!(:normal_user) {FactoryBot.create :user, email: "example@email.com"}
  let!(:course) {FactoryBot.create :course}
  let!(:user_course) {FactoryBot.create :user_course, user: user, course: course}

  before {login user}

  describe "PATCH #update" do
    context "when valid params" do
      before {patch :update,
              xhr: true,
              params: {id: user_course.id,
                       user_course: {status: "finish"}},
              session: {back_path: admin_user_courses_path}}

      it "should correct status" do
        expect(flash[:success]).to eq I18n.t("message.user_course.update_success")
      end
    end

    context "when invalid params" do
      before {patch :update,
              xhr: true,
              params: {id: user_course.id, user_course:{status: nil}}}

      it "should incorrect status" do
        expect(flash[:danger]).to eq I18n.t("message.user_course.update_fail")
      end
    end
  end
end
