class DrawingsController < ApplicationController
  before_action :set_drawing, only: [:show, :edit, :update, :destroy]

  # GET /drawings
  # GET /drawings.json
  def index
    @drawings = Drawing.all
  end

  # GET /drawings/1
  # GET /drawings/1.json
  def show
  end

  # GET /drawings/new
  def new
    @drawing = Drawing.new
  end

  # GET /drawings/1/edit
  def edit
  end

  # POST /drawings
  # POST /drawings.json
  def create
    @drawing = Drawing.new(drawing_params)

    respond_to do |format|
      if @drawing.save
        format.html { redirect_to @drawing, notice: 'Drawing was successfully created.' }
        format.json { render action: 'show', status: :created, location: @drawing }
      else
        format.html { render action: 'new' }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drawings/1
  # PATCH/PUT /drawings/1.json
  def update
    respond_to do |format|
      if @drawing.update(drawing_params)
        format.html { redirect_to @drawing, notice: 'Drawing was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @drawing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drawings/1
  # DELETE /drawings/1.json
  def destroy
    @drawing.destroy
    respond_to do |format|
      format.html { redirect_to drawings_url }
      format.json { head :no_content }
    end
  end

  def screenshot

    screenshot = Webshot::Screenshot.new
    screenshot.capture "http://www.google.com/", "output.png"

    # require 'phantomjs'
    # ws = Webshot::Screenshot.new
    # ws.capture "http://www.google.com/", "google.png"
    # ws.capture "http://www.google.com/", "google.png", width: 100, height: 90, quality: 85

    # ws.capture("http://www.google.com/", "google.png") do |magick|
    #   magick.combine_options do |c|
    #     c.thumbnail "100x"
    #     c.background "white"
    #     c.extent "100x90"
    #     c.gravity "north"
    #     c.quality 85
    #   end
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drawing
      @drawing = Drawing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def drawing_params
      params.require(:drawing).permit(:name , :photo )
    end
end
