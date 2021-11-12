FactoryBot.define do
  factory :movie_genre do
    movie { create(:movie) }
    genre { create(:genre) }
  end
end
