# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def show
    todo = Todo.find(params[:id])

    render json: todo
  end

  def create
    todo = Todo.new(todo_params)

    if todo.save
      render json: todo, status: :ok
    else
      render json: todo.error, status: :bad_request
    end
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :status)
  end
end
