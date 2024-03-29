class Api::V1::RoutesController < ApplicationController
  before_action :set_route, only: [:show, :update, :destroy]

  # GET /routes
  def index
    @routes = Route.all

    render json: @routes
  end

  # GET /routes/1
  def show
    render json: @route
    #render :show
  end

  # POST /routes
  def create
    @route = Route.new(route_params)

    if @route.save
      render json: @route, status: :created, location: url_for([:api, :v1, @route])

    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /routes/1
  def update
    if @route.update(route_params)
      render json: @route
    else
      render json: @route.errors, status: :unprocessable_entity
    end
  end

  # DELETE /routes/1
  def destroy
    @route.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      @route = Route.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def route_params
      #params.require(:route).permit(:calification, :latitude, :longitude)
      params.require(:route)
      .permit(:calification, :latitude, :longitude,
        creator: [ :name, :id2 ], members: [ :name, :id2 ],
        chat: [ :name, message: [ :content, creator: [ :name, :id2 ] ] ] )
    end
end
