class BandsController < ApplicationController    
  before_action :ensure_login 

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(name: params[:band][:name])
    if @band.save
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def new
    @band = Band.new
    render :new
  end

  def edit
    @band = Band.find_by(id: params[:id])
    render :edit
  end

  def show
    @band = Band.find_by(id: params[:id])
    @albums = @band.albums
    if @band
      render :show
    else
      redirect_to bands_url
    end
  end

  def update
    @band = Band.find_by(id: params[:id])
    if @band.update(name: params[:band][:name])
      redirect_to bands_url
    else
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def destroy
    @band = Band.find_by(id: params[:id])

    @band.destroy
    redirect_to bands_url
  end
end
