# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def show
    render json: Todo.find(params[:id])
  end

  def create
    todo = Todo.new(todo_params)

    todo.save!

    render json: todo, status: :ok
  end

  def update
    todo = Todo.find(params[:id])

    todo.update!(todo_params)

    render json: todo, status: :ok
  end

  def destroy
    todo = Todo.find(params[:id])
    todo.destroy!
    render json: {}, status: :ok
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :description, :status)
  end
end
