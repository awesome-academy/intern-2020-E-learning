require "rails_helper"

RSpec.describe UserCoursesController, type: :controller do
  let!(:user) {FactoryBot.create :user}
  let!(:course) {FactoryBot.create :course}
  let!(:course_2) {FactoryBot.create :course}
  let!(:course_3) {FactoryBot.create :course}

  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "renders the 'index' template" do
      expect(response).to render_template :index
    end

    it "load all course" do
      expect(assigns(:courses).pluck(:id)).to eq [course.id,
                                                  course_2.id,
                                                  course_3.id]
    end
  end
end
