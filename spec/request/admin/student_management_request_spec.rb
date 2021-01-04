require "rails_helper"

RSpec.describe Admin::StudentManagementsController, type: :controller do
  let(:course) {FactoryBot.create :course}
  let(:course_two) {FactoryBot.create :course}
  let(:course_three) {FactoryBot.create :course}
  let!(:user) {FactoryBot.create :user, role: :admin}
  let(:normal_user) {FactoryBot.create :user}
  let!(:user_course_pending) do
    FactoryBot.create :user_course,
                      user: normal_user,
                      course: course,
                      status: Settings.status.pending
  end
  let!(:user_course_learning) do
    FactoryBot.create :user_course,
                      user: normal_user,
                      course: course_two,
                      status: Settings.status.learning
  end
  let!(:user_course_not_allowed) do
    FactoryBot.create :user_course,
                      user: normal_user,
                      course: course_three,
                      status: Settings.status.not_allowed
  end

  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    context "when loading without pending status" do
      it "expect return all active course" do
        expect(assigns(:courses).pluck(:id)).to eq [course_three.id,
                                                    course_two.id,
                                                    course.id]
      end
    end

    context "when loading with pending status" do
      before {get :index, params: {page: 1}, params: {pending: true}}

      it "expect return all active course that have pending user" do
        expect(assigns(:courses).pluck(:id)).to eq [course.id]
      end
    end

    it "renders the 'index' template" do
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    context "when id is invalid" do
      before {get :show, params: {id: 250000}}

      it "expect to redirect to 404" do
        expect(response.status).to eq 404
      end
    end

    context "when id is valid" do
      before {get :show, params: {id: course.id}}

      it "expect to return correct course" do
        expect(assigns(:course).id).to eq course.id
      end

      it "expect to render show" do
        expect(response).to render_template :show
      end
    end
  end
end
