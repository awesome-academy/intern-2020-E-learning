require "rails_helper"

RSpec.describe CommentsController, type: :controller do
  let(:valid_params) {FactoryBot.attributes_for :comment, user: user}
  let(:invalid_params) {FactoryBot.attributes_for :comment,
                                                  user: user,
                                                  content: Faker::Lorem.words(number: 400).join(" ") }
  let!(:user) {FactoryBot.create :user}
  let!(:course_lecture) {FactoryBot.create :course_lecture}
  let!(:comment) {FactoryBot.create :comment, commentable: course_lecture}
  let!(:comment_two) {FactoryBot.create :comment, commentable: course_lecture}
  let!(:comment_three) {FactoryBot.create :comment, commentable: course_lecture}

  before {login user}

  describe "GET #index" do
    before {get :index, params: {course_lecture_id: course_lecture.id,
                                 locale: :vi}}

    it "renders the 'index' template" do
      expect(response).to render_template :index
    end

    it "assigns @comments" do
      expect(assigns(:comments).pluck(:id)).to eq [comment.id,
                                                   comment_two.id,
                                                   comment_three.id]
    end
  end

  describe "GET #new" do
    let!(:new_comment) {FactoryBot.create :comment, commentable: course_lecture}
    before {get :new, params: {course_lecture_id: course_lecture.id,
                               locale: :vi}}
    it "should render new template" do
      expect(response).to render_template :new
    end
  end

  describe "POST #create" do
    context "when valid params" do
      before {post :create, params: {comment: valid_params,
                                     course_lecture_id: course_lecture.id,
                                     locale: :vi},
              xhr: true}

      it "has a 200 status code" do
        response.code.should.eql? "200"
      end
    end
    context "when invalid params" do
      before {post :create, params: {comment: invalid_params,
                                     course_lecture_id: course_lecture.id,
                                     locale: :vi},
              xhr: true}

      it "has a 310 status code" do
        response.code.should.eql? "301"
      end
    end
  end
end
