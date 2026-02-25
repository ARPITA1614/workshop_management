FactoryBot.define do
  factory :admin_user do
    email { "admin@example.com" }
    password { "password123" }
    password_confirmation { "password123" }

    # if you use role column
    # role { "admin" }
  end
end
