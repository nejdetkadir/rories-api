FactoryBot.define do
  factory :cast do
    fullname { Faker::Name.name_with_middle }
    biography { Faker::Lorem.paragraph(sentence_count: 8) }
    image { File.open(Rails.root.join("spec", "fixtures", "files", "images", "placeholder.png")) }
  end
end
