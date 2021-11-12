FactoryBot.define do
  factory :movie_cast do
    movie { create(:movie) }
    cast { create(:cast) }
    role { MovieCast.roles.values.sample }
  end
end
