class Admin::WorkshopsController < AdminController
  # before_action :set_workshop, only: %i[show, destroy]

  def index
    @q = Workshop.ransack(params[:q])
    @workshops = @q.result
  end

  def show
    @workshop = Workshop.friendly.find(params[:id])
  end


  def destroy
    @workshop = Workshop.friendly.find(params[:id])
    @workshop.destroy
      redirect_to admin_workshops_path, notice: "Workshop deleted successfully"
  end

  def new
    @workshop = Workshop.new
  end

  def create
    @workshop = Workshop.new(workshop_params)
    if @workshop.save
      redirect_to admin_workshops_path, notice: "Workshop created successfully"
    else
      render :new 
    end
  end


  private
  def workshop_params
       params.require(:workshop).permit(:name, :description, :start_date, :end_date, :start_time, :end_time, :total_sits, :remaining_sits, :registration_fee, :image)
  end
  # def set_workshop
  #   @workshop = Workshop.friendly.find(params[:id])
  # end
end