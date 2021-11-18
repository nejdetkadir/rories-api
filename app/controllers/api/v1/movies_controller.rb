class Api::V1::MoviesController < Api::V1::FollowableController
  before_action :set_movie, only: [:show]
  before_action :set_movie_for_followable, only: [:follow, :unfollow]

  def index
    render json: Movie.page(params[:page]), status: :ok, include: [
      :cast => {
        only: [
          :id,
          :fullname
        ]
      },
      :genres => {
        only: [
          :id,
          :name
        ]
      }
    ], except: [
      :created_at,
      :updated_at
    ]
  end

  def show
    @movie = { is_following: true, movie: @movie.as_json(
      include: movie_include,
      except: movie_except
    ) } if check_user_following(@movie)

    render json: @movie, status: :ok, except: movie_except, include: movie_include
  end

  def search
    @q = Movie.ransack(search_params)

    render json: @q.result.limit(24), status: :ok, except: movie_except, include: movie_include
  end

  def follow
    super @movie
  end

  def unfollow
    super @movie
  end

  protected

    def movie_include
      [
        :genres => {
          except: [
            :created_at,
            :updated_at
          ]
        }
      ]
    end

    def movie_except
      [
        :created_at,
        :updated_at
      ]
    end

  private

    def search_params
      params.require(:q).permit(:title_cont)
    end

    def set_movie_for_followable
      @movie = Movie.find(params[:movie_id])
    end

    def set_movie
      @movie = Movie.find(params[:id])
    end
end
