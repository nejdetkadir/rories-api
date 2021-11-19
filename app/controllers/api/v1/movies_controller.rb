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
    render json: @movie.as_json(
      include: [
        :genres => {
          except: [
            :created_at,
            :updated_at
          ]
        }
      ], except: [
        :created_at,
        :updated_at
      ]
    ).merge({
      is_following: current_user.is_following?(@movie)
    }), status: :ok
  end

  def search
    @q = Movie.ransack(search_params)

    render json: @q.result.limit(24), status: :ok, except: [
      :created_at,
      :updated_at
    ], include: [
      :genres => {
        except: [
          :created_at,
          :updated_at
        ]
      }
    ]
  end

  def follow
    super @movie
  end

  def unfollow
    super @movie
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
