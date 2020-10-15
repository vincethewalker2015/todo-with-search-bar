class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  
  def new
    @todo = Todo.new
    #@todo = Todo.paginate(page: params[:page], per_page: 5)
  end
  
  def create
     @todo = Todo.new(todo_params)
    if @todo.save
      flash[:success] = "Todo was successfully created"
      redirect_to todo_path(@todo)
    else
      flash[:danger] ="Nope... Try it again"
      render 'new'
    end
  end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    if @todo.update(todo_params)
      flash[:success] = "Todo was successfully Updated"
      redirect_to todo_path(@todo)
    else
      flash[:danger] = "That didn't work well! try again..."
      render 'edit'
    end
  end
  
  def index
    @todos = Todo.all
  end
  
  def destroy
     @todo.destroy
     flash[:success] = "Todo was deleted Successfully"
     redirect_to todos_path
  end

  def search
    if params[:todo].present?
      @todos = params[:todo].present? # This can create multiple results thus the choice to change from @friend to @friends
        @todos = Todo.search(params[:todo])
        if @todos && @todos.count > 1
          respond_to do |format|
            format.js { render partial: 'todos/todo_result' }
          end
        else
          respond_to do |format|
            flash.now[:danger] = "There are No Todo's found for this request.."
            format.js { render partial: 'todos/todo_result' }
          end
        end
      else
        respond_to do |format|
          flash.now[:alert] = "Please enter a Todo name or description to search"
          format.js { render partial: 'todos/todo_result' }
        end
      end
    end
  
  private
  
  def set_todo
    @todo = Todo.find(params[:id])
  end
  
  def todo_params
    params.require(:todo).permit(:name, :description)
  end

end
