# frozen_string_literal: true

class TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def show
    todo = Todo.find(params[:id])

    render json: todo
  end
end
