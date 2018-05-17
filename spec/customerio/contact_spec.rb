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
        other: false
      )

      model.save
      analytics = double
      contact = CustomerIO::Contact.new(model, analytics)

      expect(analytics).to receive(:identify).with("testemail@example.com", {
        traits: {
          first_name: "Test",
          last_name: "Person",
          email: "testemail@example.com",
          b2c_customer: true,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: false,
          other: false,
          marketing_consent_given: true
        }
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
        other: false
      )
      
      model.save
      analytics = double
      contact = CustomerIO::Contact.new(model, analytics)

      expect(analytics).to receive(:identify).with("testemail@example.com", {
        traits: {
          first_name: "Test",
          last_name: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: true,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: false,
          other: false,
          marketing_consent_given: true
        }
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
        other: false
      )
      
      model.save
      analytics = double
      contact = CustomerIO::Contact.new(model, analytics)

      expect(analytics).to receive(:identify).with("testemail@example.com", {
        traits: {
          first_name: "Test",
          last_name: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: true,
          b2c_fellow: false,
          b2b_person: false,
          other: false,
          marketing_consent_given: true
        }
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
        other: false
      )
      
      model.save
      analytics = double
      contact = CustomerIO::Contact.new(model, analytics)

      expect(analytics).to receive(:identify).with("testemail@example.com", {
        traits: {
          first_name: "Test",
          last_name: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: true,
          b2b_person: false,
          other: false,
          marketing_consent_given: true
        }
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
        other: false
      )
      
      model.save
      analytics = double
      contact = CustomerIO::Contact.new(model, analytics)

      expect(analytics).to receive(:identify).with("testemail@example.com", {
        traits: {
          first_name: "Test",
          last_name: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: true,
          other: false,
          marketing_consent_given: false
        }
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
        other: true
      )
      
      model.save
      analytics = double
      contact = CustomerIO::Contact.new(model, analytics)

      expect(analytics).to receive(:identify).with("testemail@example.com", {
        traits: {
          first_name: "Test",
          last_name: "Person",
          email: "testemail@example.com",
          b2c_customer: false,
          b2c_alumnus: false,
          b2c_apprentice: false,
          b2c_fellow: false,
          b2b_person: false,
          other: true,
          marketing_consent_given: false
        }
      })

      contact.sync
    end
  end
end