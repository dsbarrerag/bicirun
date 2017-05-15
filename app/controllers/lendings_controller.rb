class LendingsController < ApplicationController
  before_action :set_lending, only: [:show, :edit, :update, :destroy]
  protect_from_forgery except: [:assign, :return_bicycle]

  # GET /lendings
  # GET /lendings.json
  def index
    @lendings = Lending.all
  end

  # GET /lendings/1
  # GET /lendings/1.json
  def show
  end

  # GET /lendings/new
  def new
    @lending = Lending.new
  end

  # GET /lendings/1/edit
  def edit
  end

  def return_bicycle
    bicycle = Bicycle.find_by_code(params[:lending][:bicycle])
    @lending = Lending.where(bicycle: bicycle).first
    @lending.destroy
    render json: "Bicycle returned", status: :ok
  end

  def assign
    bicycle = Bicycle.find_by_code(params[:lending][:bicycle])
    student = Student.find_by_tiun(params[:lending][:student])
    respond_to do |format|
      if !bicycle.nil? && !student.nil?
        @lending = Lending.new(student_id: student.id, bicycle_id: bicycle.id)
        if @lending.save
          format.json { render :show, status: :created, location: @lending }
        else
          format.json { render json: @lending.errors, status: :unprocessable_entity }
        end
      else
        format.json { render json: "Bicycle or Student Invalid", status: :unprocessable_entity }
      end
    end
  end

  # POST /lendings
  # POST /lendings.json
  def create

    @lending = Lending.new(lending_params)
    @lending.state = :active
    respond_to do |format|
      if @lending.save
        format.html { redirect_to @lending, notice: 'Lending was successfully created.' }
        format.json { render :show, status: :created, location: @lending }
      else
        format.html { render :new }
        format.json { render json: @lending.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lendings/1
  # PATCH/PUT /lendings/1.json
  def update
    respond_to do |format|
      if @lending.update(lending_params)
        format.html { redirect_to @lending, notice: 'Lending was successfully updated.' }
        format.json { render :show, status: :ok, location: @lending }
      else
        format.html { render :edit }
        format.json { render json: @lending.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lendings/1
  # DELETE /lendings/1.json
  def destroy
    @lending.destroy
    respond_to do |format|
      format.html { redirect_to lendings_url, notice: 'Lending was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_lending
    @lending = Lending.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def lending_params
    params.require(:lending).permit(:student_id, :bicycle_id)
  end
end
