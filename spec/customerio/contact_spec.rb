require "rails_helper"
require "customerio/contact"

RSpec.describe CustomerIO::Contact do
  after do
    Contact.destroy_all
  end

  describe '#sync' do
    it 'syncs B2C Customer data with CustomerIO' do
      model = Contact.new(
        first_name: "Test", 
        last_name: "Person", 
        email: "testemail@example.com",
        b2c_customer: true,
        b2c_alumnus: false,
        b2c_apprentice: false,
        b2c_fellow: false,
        b2b_person: false,
        other: false,
        random_opt_string: 'secretstring'
      )

      model.save
      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: "testemail@example.com",
        traits: {
          firstName: "Test",
          lastName: "Person",
          email: "testemail@example.com",
          b2c_customer: true,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: false,
          other: false,
          marketing_consent: true,
          opt_in_uuid: 'secretstring',
          date_consent_given: "#{Time.now}",
          hs_legal_basis: "Legitimate interest - existing customer",
          legal_basis: "Legitimate interest - existing customer"
      })

      contact.sync
    end

    it 'syncs B2C Alumnus data with CustomerIO' do
      model = Contact.new(
        first_name: "Test", 
        last_name: "Person", 
        email: "testemail@example.com",
        b2c_customer: false,
        b2c_alumnus: true,
        b2c_apprentice: false,
        b2c_fellow: false,
        b2b_person: false,
        other: false,
        random_opt_string: 'secretstring'
      )
      
      model.save
      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: "testemail@example.com",
        traits: {
          firstName: "Test",
          lastName: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: true,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: false,
          other: false,
          marketing_consent: true,
          opt_in_uuid: 'secretstring',
          date_consent_given: "#{Time.now}",
          hs_legal_basis: "Legitimate interest - existing customer",
          legal_basis: "Legitimate interest - existing customer"
      })

      contact.sync
    end

    it 'syncs B2C Apprentice data with CustomerIO' do
      model = Contact.new(
        first_name: "Test", 
        last_name: "Person", 
        email: "testemail@example.com",
        b2c_customer: false,
        b2c_alumnus: false,
        b2c_apprentice: true,
        b2c_fellow: false,
        b2b_person: false,
        other: false,
        random_opt_string: 'secretstring'
      )
      
      model.save
      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: "testemail@example.com",
        traits: {
          firstName: "Test",
          lastName: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: true,
          b2c_fellow: false,
          b2b_person: false,
          other: false,
          marketing_consent: true,
          opt_in_uuid: 'secretstring',
          date_consent_given: "#{Time.now}",
          hs_legal_basis: "Legitimate interest - existing customer",
          legal_basis: "Legitimate interest - existing customer"
      })

      contact.sync
    end

    it 'syncs B2C Fellow data with CustomerIO' do
      model = Contact.new(
        first_name: "Test", 
        last_name: "Person", 
        email: "testemail@example.com",
        b2c_customer: false,
        b2c_alumnus: false,
        b2c_apprentice: false,
        b2c_fellow: true,
        b2b_person: false,
        other: false,
        random_opt_string: 'secretstring'
      )
      
      model.save
      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: "testemail@example.com",
        traits: {
          firstName: "Test",
          lastName: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: true,
          b2b_person: false,
          other: false,
          marketing_consent: true,
          opt_in_uuid: 'secretstring',
          date_consent_given: "#{Time.now}",
          hs_legal_basis: "Legitimate interest - existing customer",
          legal_basis: "Legitimate interest - existing customer"
      })

      contact.sync
    end

    it 'syncs B2B Person data with CustomerIO' do
      model = Contact.new(
        first_name: "Test", 
        last_name: "Person", 
        email: "testemail@example.com",
        b2c_customer: false,
        b2c_alumnus: false,
        b2c_apprentice: false,
        b2c_fellow: false,
        b2b_person: true,
        other: false,
        random_opt_string: 'secretstring'
      )
      
      model.save
      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: "testemail@example.com",
        traits: {
          firstName: "Test",
          lastName: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: true,
          other: false,
          marketing_consent: false,
          opt_in_uuid: 'secretstring',
          date_consent_given: nil,
          hs_legal_basis: "Legitimate interest - prospect/lead",
          legal_basis: "Legitimate interest - prospect/lead"
      })

      contact.sync
    end

    it 'syncs Other Person data with CustomerIO' do
      model = Contact.new(
        first_name: "Test", 
        last_name: "Person", 
        email: "testemail@example.com",
        b2c_customer: false,
        b2c_alumnus: false,
        b2c_apprentice: false,
        b2c_fellow: false,
        b2b_person: false,
        other: true,
        random_opt_string: 'secretstring'
      )
      
      model.save
      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: "testemail@example.com",
        traits: {
          firstName: "Test",
          lastName: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: false,
          other: true,
          marketing_consent: false,
          opt_in_uuid: 'secretstring',
          date_consent_given: nil,
          hs_legal_basis: "Not applicable",
          legal_basis: "Not applicable"
      })

      contact.sync
    end
  end

  describe '#opt_in' do
    it 'updates CustomerIO with the user that just opted-in' do
      model = Contact.new(email: "testperson@example.com")
      model.save

      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: model.email,
        traits: {
          email: model.email,
          marketing_consent: true,
          date_consent_given: "#{Time.now}",
          hs_legal_basis: "Freely given consent from contact",
          legal_basis: "Freely given consent from contact"
      })

      expect(contact.opt_in).to be true
    end
  end

  describe '#opt_out' do
    it 'updates CustomerIO with the user that just opted-out' do
      model = Contact.new(email: "testperson@example.com")
      model.save

      client = double(flush: nil)
      analytics = double(new: client)
      contact = CustomerIO::Contact.new(model, analytics)

      expect(client).to receive(:identify).with(
        user_id: model.email,
        traits: {
          email: model.email,
          marketing_consent: false,
          date_consent_given: nil,
          hs_legal_basis: "Not applicable",
          legal_basis: "Not applicable"
      })

      expect(contact.opt_out).to be true
    end
  end
end