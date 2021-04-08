class TodosController < ApplicationController
    #skip_before_action :verify_authenticity_token
  
    def index
      #  render plain: Todo.order(:due_date).map { |todo| todo.to_pleasant_string }.join("\n")
      @todos = current_user.todos
      render "index"
    end
  
    def show
      id = params[:id]
      todo = current_user.todos.find(id)
      render plain: todo.to_pleasant_string
    end
  
    def create
      todo_text = params[:todo_text]
      due_date = params[:due_date]
      completed = false
      user_id = current_user.id
      new_todo = Todo.new(todo_text: todo_text, due_date: due_date, completed: completed, user_id: user_id)
  
      if new_todo.valid?
        new_todo.save
      else
        flash[:error] = new_todo.errors.full_messages.join(", ")
      end
      redirect_to todos_path
    end
  
    def update
      id = params[:id]
      completed = params[:completed]
  
      todo = current_user.todos.find(id)
      todo.completed = completed
      todo.save!
  
      #render plain: "The completed status of todo is #{completed}"
      redirect_to todos_path
    end
  
    def destroy
      id = params[:id]
      todo = current_user.todos.find(id)
      todo.destroy
      redirect_to todos_path
    end
  end