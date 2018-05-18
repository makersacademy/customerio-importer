require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  describe "GET opt_in" do
    it "opts in the user with a random_opt_string equal to the given opt_in_uuid" do
      contact = Contact.new(email: "test@email.com", random_opt_string: "secretstring")
      contact.save

      client = double(flush: nil)
      analytics = double(new: client)
      stub_const("Segment::Analytics", analytics)

      analytics_traits = { user_id: "test@email.com", traits: { email: "test@email.com", marketing_consent: true } }

      expect(client).to receive(:identify).with(analytics_traits)

      get(:opt_in, params: { :opt_in_uuid => "secretstring" })
    end
  end
end