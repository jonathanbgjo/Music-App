class NotesController < ApplicationController
    def create
        @note = Note.new(note_params)
        @note.user_id = current_user.id
        @note.save
        redirect_to track_url(@note.track_id)
    end
    def destroy
        @note = Note.find_by(id: params[:id])
        if @note
            @note.destroy
        end

        redirect_to track_url(@note.track_id)
    end
    private
    def note_params
        params.require(:note).permit(:user_id, :track_id, :body)
    end
end
