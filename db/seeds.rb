# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# todo#sample
Todo.destroy_all
[
  { title: 'Ruby on Railsの勉強', description: 'Ruby on Railsの勉強をします', status: :not_started },
  { title: 'React.jsの勉強', description: 'React.jsの勉強をします', status: :in_progress },
  { title: 'AWSの勉強', description: 'AWSの勉強をします', status: :done },
  { title: 'マネジメントの勉強', description: 'マネジメントの勉強をします', status: :not_started },
].each { |todo| Todo.create(todo) }
