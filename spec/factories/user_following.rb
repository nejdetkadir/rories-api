FactoryBot.define do
  factory :user_following do
    user { create(:user) }
    followable { [create(:cast), create(:movie), create(:genre)].sample }
  end
end
