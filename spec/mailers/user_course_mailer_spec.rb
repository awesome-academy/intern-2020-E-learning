require "rails_helper"

RSpec.describe UserCourseMailer, type: :mailer do
  let!(:user) {FactoryBot.create :user, email: "example@email.com"}
  let!(:course) {FactoryBot.create :course}
  describe ".change_status" do
    let(:user_course) {FactoryBot.create :user_course, user: user, course: course}
    let(:mail) {UserCourseMailer.change_status(user_course)}

    before do
      stub_const("ENV", {"EXAMPLE_ENV": "example env"})
    end

    it do
      expect(mail.to).to eq [user.email]
      expect(mail.subject).to eq I18n.t("mail.status_change_title",
                                        course_name: course.name)
    end
  end
end
