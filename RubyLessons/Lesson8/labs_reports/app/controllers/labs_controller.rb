class LabsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lab, only: %i[destroy grade mark]

  def index
    @labs = Lab.includes(:user)
  end

  def destroy
    @lab.destroy
    render turbo_stream: [
      turbo_stream.remove("lab_#{@lab.id}"),
      success_message("Lab with title #{@lab.title} deleted")
    ]
  end

  def new
    @lab = Lab.new
  end

  def create
    @lab = Lab.new(lab_params)
    if @lab.save
      redirect_to labs_path, notice: 'Lab was created'
    else
      render :new
    end
  end

  def grade; end

  def mark
    if @lab.update(mark_params)
      redirect_to labs_path, notice: 'Lab was graded'
    else
      render :grade
    end
  end

  private

  def set_lab
    @lab = Lab.find(params[:id])
  end

  def lab_params
    params.require(:lab).permit(:title, :description, :user_id)
  end

  def mark_params
    params.require(:lab).permit(:grade)
  end
end
