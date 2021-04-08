class UsersController < ApplicationController
    skip_before_action :ensure_user_logged_in
  
    def index
      render plain: User.order(:id).map { |user| user.to_pleasant_string }.join("\n")
    end
  
    def new
      render "new"
    end
  
    def create
      first_name = params[:first_name]
      last_name = params[:last_name]
      email = params[:email]
      password = params[:password]
  
      new_user = User.new(first_name: first_name, last_name: last_name, email: email, password: password)
  
      if new_user.valid?
        new_user.save
        session[:current_user_id] = new_user.id
        redirect_to todos_path
      else
        flash[:error] = new_user.errors.full_messages.join(", ")
        redirect_to new_user_path
      end
    end
  
    def show
      id = params[:id]
      user = User.find(id)
  
      render plain: user.to_pleasant_string
    end
  
    def update
      id = params[:id]
      password = params[:password]
  
      user = User.find(id)
      user.password = password
      user.save!
  
      render plain: "Password of user with id: #{id} has been updated"
    end
  end
  