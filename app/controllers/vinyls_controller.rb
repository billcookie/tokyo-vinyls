class VinylsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  skip_after_action :verify_authorized

  def index
    if params[:query].present?
      @vinyls = policy_scope(Vinyl.song_artist_search(params[:query]))
    else
      @vinyls = policy_scope(Vinyl)
    end
  end

  def show
    @vinyl = Vinyl.find(params[:id])
  end


  def new
    @vinyl = Vinyl.new
  end

  def create
    @vinyl = Vinyl.new
    @offer.user = current_user
    authorize @vinyl
    if vinyl.save
      redirect_to vinyl_path(@vinyl)
    else
      render :new, status: :unprocessable_entity
    end
  end
end
