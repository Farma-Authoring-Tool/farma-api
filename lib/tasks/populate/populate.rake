namespace :db do
  desc 'Populate local'

  task populate: :environment do
    Rake::Task['db:reset'].invoke
    puts 'Populating...'
    tasks = %w[
      users
      los
      teams
    ]

    tasks.each do |populate_task|
      Rake::Task["populate:#{populate_task}"].invoke
    end
  end
end
