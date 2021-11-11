FactoryBot.define do
  factory :cast do
    fullname { Faker::Name.name_with_middle }
    biography { Faker::Lorem.paragraph(sentence_count: 8) }
    remote_image_url { Faker::LoremPixel.image }
  end
end
