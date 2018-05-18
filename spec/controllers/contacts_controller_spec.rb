require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe "GET opt_in" do
    it "opts in the user with a random_opt_string equal to the given opt_in_uuid" do
      contact = Contact.new(email: "test@email.com", random_opt_string: "secretstring")
      contact.save

      client = double(flush: nil)
      analytics = double(new: client)
      stub_const("Segment::Analytics", analytics)

      analytics_traits = { 
        user_id: "test@email.com", 
        traits: { 
          email: "test@email.com", 
          marketing_consent: true,
          date_consent_given: "#{Time.now}",
          hs_legal_basis: "Freely given consent from contact",
          legal_basis: "Freely given consent from contact"
        } 
      }

      expect(client).to receive(:identify).with(analytics_traits)

      get(:opt_in, params: { :opt_in_uuid => "secretstring" })
    end
  end

  describe "GET opt_out" do
    it "opts out the user with a random_opt_string equal to the given opt_in_uuid" do
      contact = Contact.new(email: "test@email.com", random_opt_string: "secretstring")
      contact.save

      client = double(flush: nil)
      analytics = double(new: client)
      stub_const("Segment::Analytics", analytics)

      analytics_traits = { 
        user_id: "test@email.com", 
        traits: { 
          email: "test@email.com", 
          marketing_consent: false,
          date_consent_given: nil,
          hs_legal_basis: "Not applicable",
          legal_basis: "Not applicable"
        } 
      }

      expect(client).to receive(:identify).with(analytics_traits)

      get(:opt_out, params: { :opt_in_uuid => "secretstring" })
    end
  end
end