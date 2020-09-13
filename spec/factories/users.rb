FactoryGirl.define do
  sequence :email do |number|
    "test#{number}@test.com"
  end

  factory :user do
    first_name 'Daniel'
    last_name 'Mejia'
    email { generate :email }
    password 'Test12345'
    password_confirmation 'Test12345'
  end

  factory :admin_user, class: 'Admin' do
    first_name 'Admin'
    last_name 'User'
    email { generate :email }
    password 'Test12345'
    password_confirmation 'Test12345'
  end
end