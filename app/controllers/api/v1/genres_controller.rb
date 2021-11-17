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

    @movies = { is_following: true, movies: @movies.as_json(
      include: movies_include,
      except: movies_except
      ) } if check_user_following(@genre)

    render json: @movies, status: :ok, include: movies_include, except: movies_except
  end

  def follow
    super @genre
  end

  def unfollow
    super @genre
  end

  protected

    def movies_include
      [
        :genres => {
          except: [:created_at, :updated_at],
        }
      ]
    end

    def movies_except
      [
        :created_at,
        :updated_at,
        :success
      ]
    end

  private

    def set_genre_for_followable
      @genre = Genre.find(params[:genre_id])
    end

    def set_genre
      @genre = Genre.find(params[:id])
    end
end
