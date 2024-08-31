class NotesController < ApplicationController
  before_action :set_note, only: %i[show edit update destroy]

  def index
    if params[:query].present?
      @notes = Note.where('title LIKE ? OR content LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
    else
      @notes = Note.all
    end
  end

  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to notes_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @note.update(note_params)
      redirect_to notes_path, notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    respond_to do |format|
      format.html { redirect_to notes_path, notice: 'Note was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def note_params
    params.require(:note).permit(:title, :content)
  end

  def set_note
    @note = Note.find(params[:id])
  end
end
