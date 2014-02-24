class DrawingsController < ApplicationController
  before_filter :authenticate_user! , except: [:show]

  before_action :set_drawing, only: [:show, :edit, :update, :destroy]

  # GET /drawings
  # GET /drawings.json
  def index
    @drawings = Drawing.order('id DESC')
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
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  def screenshot
    # render :text => params.to_json
    url_path = params[:url]
    screenshot = Webshot::Screenshot.instance
    

      screenshot.capture "#{url_path}", 
      "#{current_user.name}_#{current_user.id}.png", timeout: 2 do |magick|
        magick.combine_options do |c|
        c.thumbnail "500x"
        c.extent "500x450"
        #c.gravity "north"
        c.quality 100
      end
    end
    new_drawing = current_user.drawings.new
    new_drawing.name = url_path
    new_drawing.photo = open "#{Rails.root}/#{current_user.name}_#{current_user.id}.png"
    new_drawing.save!
    
    redirect_to root_url , notice: 'Drawing was successfully capture.' 
    
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
