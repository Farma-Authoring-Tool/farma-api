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

    exercise.solution_steps.create(title: 'Passo 1',
                                   description: Faker::Lorem.paragraph,
                                   response: 'x',
                                   decimal_digits: 2,
                                   public: true)
  end
end
