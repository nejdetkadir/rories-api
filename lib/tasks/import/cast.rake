namespace :import do
  desc 'Imports cast from db/static_data'
  task cast: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'movies.yml'))
    progress_bar = ProgressBar.create(:title => "Cast", :starting_at => 0, :total => file.count)

    file.each do |movie|
      movie["cast"].split(",").each do |cast|
        current_cast = create_cast(cast.to_s.strip!)
      end

      create_cast(movie["director"])

      progress_bar&.increment
    end

  end

  def create_cast(fullname)
    Cast.create(
      fullname: fullname,
      biography: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
      image: File.open(Rails.root.join("spec", "fixtures", "files", "images", "placeholder.png"))
    )
  end
end