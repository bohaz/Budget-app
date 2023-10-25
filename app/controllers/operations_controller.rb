class OperationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @group = Group.find(params[:group_id])
    @operations = @group.operations.where(author: current_user)
    @groups = Group.joins(:operations).where(operations: { author: current_user }).distinct
  end  

  def new
    @group = Group.find(params[:group_id])
    @operation = @group.operations.build
  end

  def create
    @group = Group.find(params[:group_id])
    @operation = @group.operations.build(operation_params)
    @operation.author = current_user
  
    if @operation.save
      redirect_to group_operations_path(@group), notice: 'Operation was successfully created.'
    else
      render :new
    end
  end
  

  def show; end

  private

  def operation_params
    params.require(:operation).permit(:name, :amount)
  end
end
