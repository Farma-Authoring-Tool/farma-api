namespace :clean do
  desc 'Clean visualizations, answers, and guest users with null team'

  task clean_data: :environment do
    puts 'Cleaning introduction visualizations...'
    IntroductionsVisualization.where(team: nil).delete_all

    puts 'Cleaning exercise visualizations...'
    ExercisesVisualization.where(team: nil).delete_all

    puts 'Cleaning solution step visualizations...'
    SolutionStepsVisualization.where(team: nil).delete_all

    puts 'Cleaning tip visualizations...'
    TipsVisualization.where(team: nil).delete_all

    puts 'Cleaning answers...'
    Answer.where(team: nil).delete_all

    puts 'Cleaning guest users...'
    User.where(guest: true).delete_all

    puts 'Visualizations, answers, and guest users with null team cleaned successfully.'
  end
end
