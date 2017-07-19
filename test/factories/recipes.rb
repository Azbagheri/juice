FactoryGirl.define do

  factory :recipe do
    name       { ['Happy Kale Contender', 'BeetSpinach', 'Happy Kale Contender'].sample }
    # image    { ['22 King St', '92 Queen St', '44 Young St'].sample }
    # user_id   { rand(5..10) }
  end

end
