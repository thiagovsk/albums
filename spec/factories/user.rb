FactoryBot.define do
  factory :user do
    fullname { 'John' }
    username { 'doe' }
    password { '1234' }
    password_confirmation { '1234' }
    role { 'admin' }
  end
end
