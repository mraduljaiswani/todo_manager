class TodosController < ApplicationController
    skip_before_action :verify_authenticity_token
    def index

        # render plain:Todo.all.map{|todo| todo.to_pleasant_string}.join("\n")
        render "index"
    end
    def show
        id =params[:id]
        # # render plain: "the id u wanted was #{id}"
        todo =Todo.find(id)
        render "todo"
        # render plain: todo.to_pleasant_string
    end

    def create
        todo_text = params[:todo_text]
        due_date = DateTime.parse(params[:due_date])
        new_todo = Todo.create!(
                todo_text: todo_text,
                due_date: due_date,
                completed: false,
            )
            redirect_to todos_path
        end
        def update
            id = params[:id]
            completed = params[:completed]
            
            todo=Todo.find(id)
            # todo = current_user.todos.find(id)
            todo.completed = completed
            todo.save!
            
            #render plain: "The completed status of todo is #{completed}"
            redirect_to todos_path
        end
        
        def destroy
            id = params[:id]
            # todo = current_user.todos.find(id)
            todo = Todo.find(id)
            todo.destroy
            redirect_to todos_path
        end
    end
    # response_text ="hey your new todo is created with id #{new_todo.id}"
    # render plain: response_text
# user_id = current_user.id

# if new_todo.valid?
#     new_todo.save
# else
#     flash[:error] = new_todo.errors.full_messages.join(", ")
# end
# redirect_to todos_path