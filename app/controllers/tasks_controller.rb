class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  
  def index
    # @task = current_user.tasks.build  
    # @tasks = Task.all.page(params[:page]).per(5)
    if logged_in?   
      @user = current_user
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(5)  
    end
    render template: "toppages/index"
  end
  
  def show
    # redirect_to root_url
  end
  
  def new
    # @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)  
    # @tasks = Task.all.page(params[:page]).per(5)
    @tasks = current_user.tasks.order('created_at DESC').page(params[:page]).per(5)
    if @task.save
      flash[:success] = 'Task が正常に作成されました'
      render template: "toppages/index"
    else
      flash.now[:danger] = 'Task が作成されませんでした'
      render template: "toppages/index"
    end
  end
  
  def edit
  end
  
  def update
    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to root_url
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def set_task
    begin
      @task = current_user.tasks.find(params[:id])  # form_for 用
    rescue => e
      redirect_to root_url
    end
  end
  
  #Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status, :user_id)
  end
end
