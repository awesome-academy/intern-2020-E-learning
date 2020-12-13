require "rails_helper"

RSpec.describe UserCourse, type: :model do
  let!(:user_course_learning) do
    FactoryBot.create :user_course, status: :learning
  end
  let!(:user_course_pending) do
    FactoryBot.create :user_course, status: :pending
  end
  let!(:user_course_not_allowed) do
    FactoryBot.create :user_course, status: :not_allowed
  end
  let!(:user_course_finish) do
    FactoryBot.create :user_course, status: :finish
  end

  describe "Validations" do
    let(:user) {FactoryBot.create :user}
    let(:course) {FactoryBot.create :course}
    let(:user_course) {FactoryBot.build :user_course, user: user, course: course}
    let(:invalid_user_course) {FactoryBot.build :user_course}

    it "valid all fields" do
      expect(user_course.valid?).to eq true
    end

    it "invalid any fields" do
      expect(invalid_user_course.valid?).to eq false
    end
  end

  describe "Enums" do
    it "status" do
      is_expected.to define_enum_for(:status)
                 .with_values learning: 0, pending: 1, finish: 2, not_allowed: 3
    end
    it "relationship" do
      is_expected.to define_enum_for(:relationship)
                 .with_values student: 0, instructor: 1
    end
  end

  describe "Scope" do
    describe ".by_status" do
      it "should return user course with pending status" do
        expect(UserCourse.by_status("pending")).to include user_course_pending
      end

      it "should return user course with finish status" do
        expect(UserCourse.by_status("finish")).to include user_course_finish
      end

      it "should return user course with learning status" do
        expect(UserCourse.by_status("learning")).to include user_course_learning
      end

      it "should return user course with not_allowed status" do
        expect(UserCourse.by_status("not_allowed")).to include user_course_not_allowed
      end
    end

    describe ".by_user_id" do
      let(:user) {FactoryBot.create :user}
      let(:user_course_specific_user) {FactoryBot.create :user_course, user: user}
      it "should return correct user" do
        expect(UserCourse.by_user_id(user.id)).to include user_course_specific_user
      end
    end
  end
end
