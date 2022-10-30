class TasksController < ApplicationController
  # before_action :set_task, only: [ :show, :edit, :update, :destroy ]
  before_action :set_task, except: [:index, :new, :create, :send_mail]

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit;end

  def show;end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def send_mail
    tasks = Task.all.where('due_date > ?', DateTime.now)
    NotifyMailer.notify(tasks, params[:email]).deliver_now
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: "Mail sent to #{params[:email]} with upcomming tasks" }
      format.json { render :index, status: :ok, message: 'Mail sent to #{params[:email]} with upcomming tasks.' }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :due_date, :content, :completed)
    end
end
