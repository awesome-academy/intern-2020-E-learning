FactoryBot.define do
  factory :user_course do
    status {Settings.status.pending}
    relationship{Settings.relationship.student}
    user
    course
  end
end
