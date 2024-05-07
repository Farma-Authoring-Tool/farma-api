namespace :populate do
  desc 'Populate team'

  task teams: :environment do
    puts 'Populating team...'
    professor = User.find_by(email: 'professor@teste.com')
    student = User.find_by(email: 'aluno@teste.com')
    lo = Lo.find_by(title: 'Objeto de aprendizagem teste')
    team = Team.create(name: Faker::Educator.course_name, code: "##{Faker::Alphanumeric.alpha(number: 6)}",
                       user_id: professor.id)
    team.users << student
    team.los << lo
  end
end
