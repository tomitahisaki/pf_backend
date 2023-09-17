class TodosController < ApplicationController
  def index
    todos = Todo.all.order(created_at: :desc)

    render json: todos
  end

end
