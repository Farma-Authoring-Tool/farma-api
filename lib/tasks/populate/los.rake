namespace :populate do
  desc 'Populate Los'

  task los: :environment do
    puts 'Populating los...'
    professor = User.find_by(email: 'professor@teste.com')

    lo = professor.los.create(title: 'Objeto de Aprendizagem',
                              description: Faker::Lorem.paragraph)

    lo.introductions.create(title: 'Introdução 1',
                            description: Faker::Lorem.paragraph,
                            public: true)

    exercise = lo.exercises.create(title: 'Exercício 1',
                                   description: Faker::Lorem.paragraph,
                                   public: true)

    solution_step = exercise.solution_steps.create(title: 'Passo 1',
                                                   description: Faker::Lorem.paragraph,
                                                   response: 'x',
                                                   decimal_digits: 2,
                                                   public: true)

    solution_step.tips.create(title: 'Dica inicial', description: 'É multiplo de 3')
    solution_step.tips.create(title: 'Dica 2', description: 'É um número par')
    solution_step.tips.create(title: 'Dica 3', description: 'Pense em fatores')

    solution_step.tips.each_with_index do |tip, index|
      tip.update(position: tip.position + index)
    end
  end
end
