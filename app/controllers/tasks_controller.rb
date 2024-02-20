class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def tracking_board
    @todo_tasks = Task.where(status: :todo)
    @in_progress_tasks = Task.where(status: :in_progress)
    @done_tasks = Task.where(status: :done)
    markdown = File.read(Rails.root.join('app', 'views', 'documentation','ruby_on_rails','getting_started.html.md'))
    @html_content = render_markdown(markdown)
  end

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Task was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    @task.update(task_params)
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task was successfully destroyed.'
  end

  private

  private

  def render_markdown(markdown)
    renderer = Redcarpet::Render::HTML.new
    markdown_parser = Redcarpet::Markdown.new(renderer)
    markdown_parser.render(markdown).html_safe
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :status, :priority)
  end
end