namespace :populate do
  desc 'Populate academics'

  task users: :environment do
    puts 'Populating users...'
    User.create(email: 'testeprofessor@teste.com', password: '123456', password_confirmation: '123456',
                name: 'teste professor')
    User.create(email: 'testealuno@teste.com', password: '123456', password_confirmation: '123456',
                name: 'teste aluno')
  end
end
