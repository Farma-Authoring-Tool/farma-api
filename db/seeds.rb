# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

professor = User.create(email: 'testeprofessor@teste.com', password: '123456', password_confirmation: '123456',
                        name: 'teste professor')
student = User.create(email: 'testealuno@teste.com', password: '123456', password_confirmation: '123456',
                      name: 'teste aluno')

lo = Lo.create(
  title: 'Objeto de aprendizagem teste',
  description: 'descrição teste',
  user_id: professor.id
)

Introduction.create(
  title: 'intro 1',
  description: 'conteudo introducao 1',
  public: true,
  lo_id: lo.id
)

exercise = Exercise.create(
  title: 'exercicio 1',
  description: 'teste exercicio 1',
  public: true,
  lo_id: lo.id
)

SolutionStep.create(
  title: 'passo de solucao 1',
  description: 'descricao passo solucao 1',
  response: 'valor de x',
  decimal_digits: 2,
  public: true,
  exercise_id: exercise.id
)

team = Team.create(name: 'Turma 1', code: 'turma1', user_id: professor.id)
team.users << student
team.los << lo
