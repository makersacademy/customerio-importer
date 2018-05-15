namespace :import do
  desc "Imports data from the real-life GDPR master CSV"
  task :master => :environment do
    MASTER_CSV_PATH = "#{ Rails.root }/data/gdpr_data.csv"
    Contact.import_from_csv(MASTER_CSV_PATH, logs: true)
  end
end