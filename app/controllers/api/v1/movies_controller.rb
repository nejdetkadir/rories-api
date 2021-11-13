class Api::V1::MoviesController < ApplicationController
  before_action :set_movie, only: [:show]

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
    render json: @movie, status: :ok, except: [
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

  private

    def set_movie
      @movie = Movie.find(params[:id])
    end
end
