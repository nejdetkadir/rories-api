namespace :import do
  desc 'Imports movies from db/static_data'
  task movies: :environment do
    file = YAML.load_file(Rails.root.join('db', 'static_data', 'movies.yml'))
    progress_bar = ProgressBar.create(:title => "Movies", :starting_at => 0, :total => file.count)

    file.each do |movie|
      current_movie = Movie.create(
        title: movie["title"].split("(")[0].strip!,
        storyline: movie["storyline"],
        released_at: movie["title"].split("(")[1].chop,
        imdb_rating: movie["imdb_rating"],
        minutes: movie["minutes"],
        imdb_id: "tt" + ("0" * (7 - movie["imdb_id"].to_s.size)) + movie["imdb_id"].to_s,
        remote_cover_url: movie["remote_cover_url"].split("@")[0] + "@#{'@' if movie['remote_cover_url'].include?('@@')}.jpg"
      )

      # add stars
      movie["cast"].split(",").each do |cast|
        cast = Cast.find_by(fullname: cast.to_s.strip!)
        
        current_movie.movie_cast.create(cast: cast, role: :star)
      end

      # add genres
      if movie["genres"].include?("|")
        movie["genres"].split("|").each do |genre|
          current_genre = Genre.find_by(name: genre)
          current_movie.movie_genres.create(genre: current_genre)
        end
      else
        current_genre = Genre.find_by(name: movie["genres"])
        current_movie.movie_genres.create(genre: current_genre)
      end

      # add director
      director = Cast.find_by(fullname: movie["director"])
      current_movie.movie_cast.create(cast: director, role: :director)

      # add random writer
      current_movie.movie_cast.create(cast: Cast.all.sample, role: :writer)     
      
      # update progress bar
      progress_bar&.increment
    end

    puts "#{file.count - Movie.count} failed of #{file.size} movies" if Movie.count < file.count
  end
end