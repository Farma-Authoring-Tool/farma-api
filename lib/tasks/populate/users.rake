namespace :populate do
  desc 'Populate academics'

  task users: :environment do
    puts 'Populating users...'
    User.create(email: 'professor@teste.com', password: '123456', password_confirmation: '123456',
                name: Faker::Name.name)
    User.create(email: 'aluno@teste.com', password: '123456', password_confirmation: '123456',
                name: Faker::Name.name)
  end
end
