require 'rails_helper'

RSpec.describe Contact, type: :model do
  let(:csv_path) { "#{Rails.root}/spec/fixtures/test_gdpr_data.csv" }

  describe '#name' do
    it 'plops the first and last names together with a space between' do
      contact = Contact.new(first_name: "Test", last_name: "Person")

      expect(contact.name).to eq "Test Person"
    end

    it 'handles no last name, just giving the first name' do
      contact = Contact.new(first_name: "Test")

      expect(contact.name).to eq "Test"
    end

    it 'handles no first name, just giving the last name' do
      contact = Contact.new(last_name: "Person")

      expect(contact.name).to eq "Person"
    end

    it 'handles multiple names in the last name' do
      contact = Contact.new(first_name: "Tom", last_name: "Di Reglio")

      expect(contact.name).to eq "Tom Di Reglio"
    end

    it 'handles names that might be made out of spaces' do
      contact = Contact.new(first_name: " ", last_name: "Person")

      expect(contact.name).to eq "Person"
    end

    it 'is nil if the first and last names are nil' do
      contact = Contact.new

      expect(contact.name).to be_nil
    end
  end

  describe '.find_by_name' do
    it 'returns contacts whose #name is equal to the passed string' do
      contact = Contact.new(first_name: "John", last_name: "Meavis")
      contact.save

      expect(Contact.find_by_name("John Meavis")).to eq contact
    end

    it 'works for contacts with longer names' do
      contact = Contact.new(first_name: "John", last_name: "Di Reglio")
      contact.save

      expect(Contact.find_by_name("John Di Reglio")).to eq contact
    end

    it 'returns nil if a contact with that #name does not exist' do
      expect(Contact.find_by_name("Not existent")).to be_nil
    end

    it 'returns nil when given nil as a name, even if contacts exist with no name' do
      contact = Contact.new
      contact.save

      expect(Contact.find_by_name(nil)).to be_nil
    end
  end

  describe '.import_from_csv' do
    before do
      Contact.import_from_csv(csv_path)
    end

    it 'creates contacts from a CSV' do
      expect(Contact.count).not_to be_zero

      first_contact = Contact.first
      expect(first_contact.email).to eq "testperson@email.com"
      expect(first_contact.b2c_customer).to be false
      expect(first_contact.b2c_alumnus).to be false
      expect(first_contact.b2c_apprentice).to be false
      expect(first_contact.b2c_fellow).to be false
      expect(first_contact.b2b_person).to be false
      expect(first_contact.other).to be true
    end

    it 'splits names into first and last name' do
      first_contact = Contact.find_by_email("testperson@email.com")

      expect(first_contact.first_name).to eq "Test"
      expect(first_contact.last_name).to eq "Person"
      expect(first_contact.name).to eq "Test Person"
    end

    it 'splits longer names into first name and last names' do
      three_names_contact = Contact.find_by_email("threenames@email.com")

      expect(three_names_contact.first_name).to eq "Test"
      expect(three_names_contact.last_name).to eq "Person 2"
      expect(three_names_contact.name).to eq "Test Person 2"
    end

    it 'correctly capitalizes first names' do
      uppercase_first_name_contact = Contact.find_by_email("uppercasefirstname@email.com")

      expect(uppercase_first_name_contact.first_name).to eq "Test"
      expect(uppercase_first_name_contact.last_name).to eq "Person4"
      expect(uppercase_first_name_contact.name).to eq "Test Person4"
    end

    it 'correctly capitalizes last names' do
      uppercase_last_name_contact = Contact.find_by_email("uppercaselastname@email.com")

      expect(uppercase_last_name_contact.first_name).to eq "Test"
      expect(uppercase_last_name_contact.last_name).to eq "Person3"
      expect(uppercase_last_name_contact.name).to eq "Test Person3"
    end

    it 'correctly capitalizes longer names' do
      uppercase_three_names_contact = Contact.find_by_email("uppercasethreenames@email.com")

      expect(uppercase_three_names_contact.first_name).to eq "Test"
      expect(uppercase_three_names_contact.last_name).to eq "Person Longer"
      expect(uppercase_three_names_contact.name).to eq "Test Person Longer"
    end

    it 'imports blank names as nil' do
      blank_person = Contact.find_by_email("blankperson@email.com")

      expect(blank_person.name).to be_nil
    end

    it 'imports empty names as nil' do
      empty_person = Contact.find_by_email("emptyperson@email.com")

      expect(empty_person.name).to be_nil
    end

    it 'imports whitespace-only names as nil' do
      space_person = Contact.find_by_email("spaceperson@email.com")

      expect(space_person.name).to be_nil
    end

    it 'doesn\'t care about duplicate names' do
      original_name_person = Contact.find_by_email("nonduplicateemail@email.com")
      duplicate_name_person = Contact.find_by_email("differentemail@email.com")

      expect(original_name_person).not_to be_nil
      expect(original_name_person.name).to eq "Duplicate Name"

      expect(duplicate_name_person).not_to be_nil
      expect(duplicate_name_person.name).to eq "Duplicate Name"
    end

    it 'skips blank emails' do
      blank_email_person = Contact.find_by_name("Blank Email")

      expect(blank_email_person).to be_nil
    end

    it 'skips emails that are just whitespace' do
      whitespace_email_person = Contact.find_by_name("Space Email")

      expect(whitespace_email_person).to be_nil
    end

    it 'correctly lowercases emails' do
      uppercase_email_person = Contact.find_by_name("Test Person5")

      expect(uppercase_email_person.email).to eq "uppercaseemail@email.com"
    end

    it 'doesn\'t duplicate records with duplicate emails' do
      duplicate_records = Contact.where(email: "duplicateemail@email.com")

      expect(duplicate_records.count).to eq 1
    end

    it 'updates records with missing info from duplicate emails' do
      updated_record = Contact.find_by_email("duplicate@email.com")

      expect(updated_record.first_name).to eq "Updated"
      expect(updated_record.last_name).to eq "Duplicate"
      expect(updated_record.b2c_customer).to be true
      expect(updated_record.b2c_alumnus).to be false
    end

    it 'doesn\'t override bona fide info with blanks or nils when updating records' do
      updated_record = Contact.find_by_email("duplicate1@email.com")

      expect(updated_record.first_name).to eq "Persistent"
      expect(updated_record.last_name).to eq "Name"
    end
  end
end
