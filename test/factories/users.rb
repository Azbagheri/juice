FactoryGirl.define do

  factory :user do
    user_name       { ['Sarah', 'Bob', 'Azadeh'].sample }
    email   { ['Sarah@gmail.com', 'Bob@gmail.com', 'Azadeh@gmail.com'].sample }
    password   'password'
    password_confirmation   'password' 
  end

end
