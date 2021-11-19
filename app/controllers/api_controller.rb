class ApiController < ApplicationController
  before_action :authenticate!
end