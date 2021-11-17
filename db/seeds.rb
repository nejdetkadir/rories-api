# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Import all static data
Rake::Task['import:all'].invoke

progress_bar = ProgressBar.create(:title => "Creating demo records", :starting_at => 0, :total => 5)

# demo records
# 5.times {
#   Cast.create!(fullname: Faker::Name.name_with_middle, biography: Faker::Lorem.paragraph(sentence_count: 6), remote_image_url: Faker::LoremPixel.image)

#   5.times {
#     movie = Movie.create!(
#       title: Faker::Movie.title,
#       storyline: Faker::Lorem.paragraph(sentence_count: 4),
#       remote_cover_url: Faker::LoremPixel.image,
#       imdb_id: "tt#{rand 10000..999999}",
#       imdb_rating: (rand * 10).to_f,
#       minimum_age: rand(3..18),
#       minutes: rand(1..200),
#       released_at: rand(1900..Date.today.year)
#     )

#     movie.movie_genres.create!(genre: Genre.first)
#   }

#   User.create!(email: Faker::Internet.email, password: "123456", password_confirmation: "123456")

#   progress_bar&.increment
# }