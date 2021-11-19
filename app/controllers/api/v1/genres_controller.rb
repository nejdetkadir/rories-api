class Api::V1::GenresController < Api::V1::FollowableController
  before_action :set_genre, only: [:show]
  before_action :set_genre_for_followable, only: [:follow, :unfollow]

  def index
    @genres = Genre.all

    render json: @genres, status: :ok, except: [
      :created_at,
      :updated_at
    ]
  end

  def show
    @movies = @genre.movies.page(params[:page])

    render json: {
      movies: @movies.as_json(
        include: [
          :genres => {
            except: [:created_at, :updated_at],
          }
        ], except: [
          :created_at,
          :updated_at,
          :success
        ]
      ),
      is_following: current_user.is_following?(@genre),
      genre: @genre.as_json(
        only: [
          :id,
          :name
        ]
      )
    }, status: :ok
  end

  def follow
    super @genre
  end

  def unfollow
    super @genre
  end

  private

    def set_genre_for_followable
      @genre = Genre.find(params[:genre_id])
    end

    def set_genre
      @genre = Genre.find(params[:id])
    end
end
