namespace :populate do
  desc 'Populate Los'

  task los: :environment do
    puts 'Populating los...'
    professor = User.find_by(email: 'testeprofessor@teste.com')
    lo = Lo.create(title: 'Objeto de aprendizagem teste', description: 'descrição teste', user_id: professor.id)
    Introduction.create(title: 'intro 1', description: 'conteudo introducao 1', public: true, lo_id: lo.id)
    exercise = Exercise.create(title: 'exercicio 1', description: 'teste exercicio 1', public: true, lo_id: lo.id)
    SolutionStep.create(title: 'passo de solucao 1', description: 'descricao passo solucao 1',
                        response: 'valor de x', decimal_digits: 2, public: true, exercise_id: exercise.id)
  end
end
