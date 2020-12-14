FactoryBot.define do
  factory :user_course do
    status {Settings.status.pending}
    relationship{Settings.relationship.student}
    user_id {Settings.default_id}
    course_id {Settings.default_id}
  end
end
