class Api::V1::FeedController < ApiController
  def index
    @movie_ids = []

    @movie_ids += get_from_movie_cast({
      cast_id: current_user.following_ids[:cast_ids]
      }, :movie_id)

    @movie_ids += get_from_movie_genres({
      genre_id: current_user.following_ids[:genre_ids]
      }, :movie_id)
    
    cast_ids_of_following_movies = get_from_movie_cast({
      movie_id: current_user.following_ids[:movie_ids]
      }, :cast_id)

    @movie_ids += get_from_movie_cast({
      cast_id: cast_ids_of_following_movies
      }, :movie_id)
    
    genre_ids_of_following_movies = get_from_movie_genres({
      movie_id: current_user.following_ids[:movie_ids]
      }, :genre_id)

    @movie_ids += get_from_movie_genres({
      genre_id: genre_ids_of_following_movies
      }, :movie_id)

    render json: Movie.where(id: @movie_ids.uniq).page(params[:page])
  end

  private

    def get_from_movie_cast(query, attr)
      MovieCast.where(query).map(&attr)
    end

    def get_from_movie_genres(query, attr)
      MovieGenre.where(query).map(&attr)
    end
end