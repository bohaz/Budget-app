class OperationsController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @operations = @group.operations
  end

  def show; end
end
