namespace :populate do
  desc 'Populate team'

  task teams: :environment do
    puts 'Populating team...'
    professor = User.find_by(email: 'testeprofessor@teste.com')
    student = User.find_by(email: 'testealuno@teste.com')
    lo = Lo.find_by(title: 'Objeto de aprendizagem teste')
    team = Team.create(name: 'Turma 1', code: 'turma1', user_id: professor.id)
    team.users << student
    team.los << lo
  end
end
