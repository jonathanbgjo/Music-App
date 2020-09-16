class TracksController < ApplicationController
    before_action :ensure_login 
    def new
        @track = Track.new
        @albums = Album.find_by(id: params[:album_id]).band.albums
        render :new
    end

    def create
        @track = Track.new(track_params)
        if @track.save
            redirect_to album_url(@track.album_id)
        else
            flash.now[:errors] = @track.errors.full_messages
            render :new
        end
    end

    def show
        @track = Track.find_by(id: params[:id])
        @album = Album.find_by(id: @track.album_id)
        @notes = @track.notes
        if @track
            render :show
        else
            redirect_to bands_url
        end
    end

    def edit
        @track = Track.find_by(id: params[:id])
        @albums = @track.band.albums
        render :edit
    end

    def update
        @track = Track.find_by(id: params[:id])
        if @track.update(track_params)
            redirect_to track_url(@track)
        else
            flash.now[:errors]= @track.errors.full_messages
            render :edit
        end
    end

    def destroy
        @track = Track.find_by(id: params[:id])

        if @track
            @track.destroy
            redirect_to album_url(@track.album_id)
        else
            redirect_to bands_url
        end
    end

    private

    def track_params
        params.require(:track).permit(:title, :album_id, :ord, :lyrics, :bonus)
    end
end
