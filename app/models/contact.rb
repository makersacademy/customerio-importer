require 'csv'

class Contact < ApplicationRecord
  EMAIL_LIST_SEPARATOR = ", ".freeze

  def name
    return nil unless first_name || last_name
    "#{first_name} #{last_name}".strip
  end

  def self.generate_random_opt_strings
    all.each do |contact|
      contact.random_opt_string = "#{SecureRandom.hex}#{SecureRandom.hex}"
      contact.save
    end
  end

  def self.import_from_csv(path_to_csv, logs: false)
    created = 0
    updated = 0
    skipped = 0

    CSV.foreach(path_to_csv, headers: true) do |row|
      if logs
        print "Processing row #{$.}. Created: #{created}. Updated: #{updated}. Skipped: #{skipped}.\n"
      end

      next skipped += 1 unless email_list = sanitized_email(row["Email"])

      email_list.split(EMAIL_LIST_SEPARATOR).each do |email|
        if existing_record = find_by_email(email)
          update_from_row(row, email, existing_record)
          updated += 1
        else
          create_from_row(row, email)
          created += 1
        end
      end
    end
  end

  private

  CSV_TRUE_VALUE = "TRUE".freeze

  def self.find_by_name(name)
    return nil unless name

    first_name, *last_names = name.split(" ")
    where(first_name: first_name, last_name: last_names.join(" ")).first
  end

  def self.update_from_row(row, email, existing_record)
    new_first_name = first_name(row["Name"]).nil? ? existing_record.first_name : first_name(row["Name"])
    new_last_name  = last_name(row["Name"]).nil?  ? existing_record.last_name  : last_name(row["Name"])

    existing_record.update(
      first_name:     new_first_name,
      last_name:      new_last_name,
      email:          email,
      b2c_customer:   row["B2C Customer (Opt-out)"]   == CSV_TRUE_VALUE,
      b2c_alumnus:    row["B2C Alumnus (Opt-out)"]    == CSV_TRUE_VALUE,
      b2c_apprentice: row["B2C Apprentice (Opt-out)"] == CSV_TRUE_VALUE,
      b2c_fellow:     row["B2C Fellow (Opt-out)"]     == CSV_TRUE_VALUE,
      b2b_person:     row["B2B Person (don't send)"]  == CSV_TRUE_VALUE,
      other:          row["Other (opt-in)"]           == CSV_TRUE_VALUE
    )
  end

  def self.create_from_row(row, email)
    # Rows are as follows:
    # #<CSV::Row 
    #   "Name":"Test Person" 
    #   "Email":"testperson@email.com" 
    #   "B2C Customer (Opt-out)":"FALSE" 
    #   "B2C Alumnus (Opt-out)":"FALSE" 
    #   "B2C Apprentice (Opt-out)":"FALSE" 
    #   "B2C Fellow (Opt-out)":"FALSE" 
    #   "B2B Person (don't send)":"FALSE" 
    #   "Other (opt-in)":"TRUE" 
    #   "In more than one segment (check manually)":"FALSE"
    # >
    create(
      first_name:     first_name(row["Name"]),
      last_name:      last_name(row["Name"]),
      email:          email,
      b2c_customer:   row["B2C Customer (Opt-out)"]   == CSV_TRUE_VALUE,
      b2c_alumnus:    row["B2C Alumnus (Opt-out)"]    == CSV_TRUE_VALUE,
      b2c_apprentice: row["B2C Apprentice (Opt-out)"] == CSV_TRUE_VALUE,
      b2c_fellow:     row["B2C Fellow (Opt-out)"]     == CSV_TRUE_VALUE,
      b2b_person:     row["B2B Person (don't send)"]  == CSV_TRUE_VALUE,
      other:          row["Other (opt-in)"]           == CSV_TRUE_VALUE
    )
  end

  def self.sanitized_email(email)
    return nil if email.blank?
    return email.downcase
  end

  def self.first_name(name)
    return nil if name.blank?

    first_name, * = name.split(" ")
    return first_name.capitalize
  end

  def self.last_name(name)
    return nil if name.blank?

    first_name, *last_names = name.split(" ")
    return last_names.map(&:capitalize).join(" ")
  end

  def self.email_exists?(row)
    !sanitized_email(row["Email"]).nil?
  end

  def self.duplicate(email)
    find_by_email(email)
  end
end
