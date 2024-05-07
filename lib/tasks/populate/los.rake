namespace :populate do
  desc 'Populate Los'

  task los: :environment do
    puts 'Populating los...'
    professor = User.find_by(email: 'professor@teste.com')
    lo = Lo.create(title: 'Objeto de aprendizagem teste', description: Faker::Lorem.paragraph, user_id: professor.id)
    Introduction.create(title: 'intro 1', description: Faker::Lorem.paragraph, public: true, lo_id: lo.id)
    exercise = Exercise.create(title: 'exercicio 1', description: Faker::Lorem.paragraph, public: true, lo_id: lo.id)
    SolutionStep.create(title: 'passo de solucao 1', description: Faker::Lorem.paragraph,
                        response: 'valor de x', decimal_digits: 2, public: true, exercise_id: exercise.id)
  end
end
