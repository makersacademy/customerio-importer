require './lib/customerio/contact'

namespace :sync do
  desc "Syncs all contact data to CustomerIO"
  task :all => :environment do
  end

  desc "Creates seed data for testing if it doesn't exist"
  task :seed => :environment do
    test_contacts = [
      ["Test", "ContactB2CCustomer", "b2c_customer@makersacademy.com",   :b2c_customer], 
      ["Test", "ContactB2CAlumnus", "b2c_alumnus@makersacademy.com",    :b2c_alumnus],
      ["Test", "ContactB2CApprentice", "b2c_apprentice@makersacademy.com", :b2c_apprentice],
      ["Test", "ContactB2CFellow", "b2c_fellow@makersacademy.com",     :b2c_fellow],
      ["Test", "ContactB2BPerson", "b2b_person@makersacademy.com",     :b2b_person],
      ["Test", "ContactOther", "other@makersacademy.com",          :other]
    ]

    test_contacts.each do |test_contact|
      attributes = {
        first_name: test_contact[0],
        last_name: test_contact[1],
        email: test_contact[2]
      }

      attributes[test_contact[3]] = true

      Contact.create(attributes)
    end

    print "Created contacts!\n"
  end

  desc "Syncs a B2C customer test contact to CustomerIO"
  task :test_b2c_customer => :environment do
    errors = []
    test_email = "b2c_customer@makersacademy.com"
    test_contact = Contact.find_by_email(test_email)

    if test_contact.nil?
      errors << "No contact with email #{test_email} in database." unless test_contact
    else
      print "Syncing Contact: #{test_email}...\n"
      customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
      
      customerio_contact.sync
      print "Done!\n"
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end

  desc "Syncs a B2C alumnus test contact to CustomerIO"
  task :test_b2c_alumnus => :environment do
    errors = []
    test_email = "b2c_customer@makersacademy.com"
    test_contact = Contact.find_by_email(test_email)

    if test_contact.nil?
      errors << "No contact with email #{test_email} in database." unless test_contact
    else
      print "Syncing Contact: #{test_email}...\n"
      customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
      
      customerio_contact.sync
      print "Done!\n"
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end

  desc "Syncs a B2C apprentice test contact to CustomerIO"
  task :test_b2c_customer => :environment do
    errors = []
    test_email = "b2c_apprentice@makersacademy.com"
    test_contact = Contact.find_by_email(test_email)

    if test_contact.nil?
      errors << "No contact with email #{test_email} in database." unless test_contact
    else
      print "Syncing Contact: #{test_email}...\n"
      customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
      
      customerio_contact.sync
      print "Done!\n"
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end

  desc "Syncs a B2C fellow test contact to CustomerIO"
  task :test_b2c_fellow => :environment do
    errors = []
    test_email = "b2c_fellow@makersacademy.com"
    test_contact = Contact.find_by_email(test_email)

    if test_contact.nil?
      errors << "No contact with email #{test_email} in database." unless test_contact
    else
      print "Syncing Contact: #{test_email}...\n"
      customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
      
      customerio_contact.sync
      print "Done!\n"
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end

  desc "Syncs a B2B person test contact to CustomerIO"
  task :test_b2b_person => :environment do
    errors = []
    test_email = "b2b_person@makersacademy.com"
    test_contact = Contact.find_by_email(test_email)

    if test_contact.nil?
      errors << "No contact with email #{test_email} in database." unless test_contact
    else
      print "Syncing Contact: #{test_email}...\n"
      customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
      
      customerio_contact.sync
      print "Done!\n"
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end

  desc "Syncs an other person test contact to CustomerIO"
  task :test_other => :environment do
    errors = []
    test_email = "other@makersacademy.com"
    test_contact = Contact.find_by_email(test_email)

    if test_contact.nil?
      errors << "No contact with email #{test_email} in database." unless test_contact
    else
      print "Syncing Contact: #{test_email}...\n"
      customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
      
      customerio_contact.sync
      print "Done!\n"
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end

  desc "Syncs a test contact of each type to CustomerIO"
  task :test_all => :environment do
    errors = []
    test_emails = [
      "b2c_customer@makersacademy.com", 
      "b2c_alumnus@makersacademy.com",
      "b2c_apprentice@makersacademy.com",
      "b2c_fellow@makersacademy.com",
      "b2b_person@makersacademy.com",
      "other@makersacademy.com"
    ]

    test_emails.each do |test_email|
      test_contact = Contact.find_by_email(test_email)
      
      if test_contact.nil?
        errors << "No contact with email #{test_email} in database." unless test_contact
      else
        print "Syncing Contact: #{test_email}...\n"
        customerio_contact = CustomerIO::Contact.new(test_contact, Segment::Analytics, errors)
        
        customerio_contact.sync
        print "Done!\n"
      end
    end

    if errors.any?
      print "Errors:\n"
      errors.each { |error| print "#{error}\n" }
    end
  end
end