namespace :import do
  desc 'Runs all static data importing tasks'
  task all: %w[
    genres
  ]
end