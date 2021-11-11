namespace :import do
  desc 'Imports genres from db/static_data'
  task genres: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'genres.yml'))
    progress_bar = ProgressBar.create(:title => "Genres", :starting_at => 0, :total => file.count)

    file.each do |genre|
      Genre.create(genre)
      progress_bar&.increment
    end

    puts "#{file.count - Genre.count} failed of #{file.size} genres" if Genre.count < file.count
  end
end