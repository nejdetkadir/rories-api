class Api::V1::GenresController < ApplicationController
  before_action :set_genre, only: [:show]

  def index
    @genres = Genre.all

    render json: @genres, status: :ok, except: [
      :created_at,
      :updated_at
    ]
  end

  def show
    @movies = @genre.movies.page(params[:page])

    render json: @movies, status: :ok, except: [
      :created_at,
      :updated_at,
      :success
    ], include: [
      :genres => {
        except: [:created_at, :updated_at],
      }
    ]
  end

  private

    def set_genre
      @genre = Genre.find(params[:id])
    end
end
