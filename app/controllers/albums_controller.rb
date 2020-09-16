class AlbumsController < ApplicationController
    before_action :ensure_login 
    def new
        @album = Album.new
        @bands = Band.all
        render :new
    end

    def create
        @album = Album.new(album_params)
        @bands = Band.all
        if @album.save
            redirect_to band_url(@album.band_id)
        else
            flash.now[:errors] = @album.errors.full_messages
            render :new
        end
    end

    def edit
        @album = Album.find_by(id: params[:id])
        @bands = Band.all
        render :edit
    end

    def show
        @album = Album.find_by(id: params[:id])
        @band = Band.find_by(id: @album.band_id)
        @tracks = @album.tracks
        if @album
            render :show
        else
            redirect_to bands_url
        end
    end

    def update
        @album = Album.find_by(id: params[:id])
        if @album.update(album_params)
            redirect_to band_url(@album.band_id)
        else
            flash.now[:errors] = @albums.errors.full_messages
            render :edit
        end
    end

    def destroy
        @album = Album.find_by(id: params[:id])
        if @album
            @album.destroy
        end
        redirect_to albums_url
    end

    private
    def album_params
        params.require(:album).permit(:title, :year, :band_id, :live)
    end
end
