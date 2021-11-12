FactoryBot.define do
  factory :movie do
    title { Faker::Movie.title }
    storyline { Faker::Lorem.paragraph(sentence_count: 4) }
    remote_cover_url { Faker::LoremPixel.image }
    trailer { nil }
    imdb_id { "tt#{rand 10000..999999}" }
    imdb_rating { (rand * 10).to_f }
    minimum_age { rand 3..18 }
    minutes { rand 1..200 }
    released_at { Date.today.year }
  end
end
