require 'segment/analytics'

module CustomerIO
  class Contact
    def initialize(model, analytics = Segment::Analytics, errors = [])
      @model = model
      @analytics = analytics.new({
        write_key: ENV["ANALYTICS_WRITE_KEY"],
        on_error: Proc.new { |status, msg| errors << error_message(status, msg) }
      })
      @errors = errors
    end

    def sync
      @analytics.identify(user_id: @model.email, traits: analytics_traits)
      @analytics.flush
    end

    def opt_in
      @analytics.identify(user_id: @model.email, traits: opt_in_traits)
      @analytics.flush
      true
    end

    def opt_out
      @analytics.identify(user_id: @model.email, traits: opt_out_traits)
      @analytics.flush
      true
    end

    private

    def analytics_traits
      {
        email:          @model.email,
        firstName:      @model.first_name,
        lastName:       @model.last_name,
        b2c_customer:   @model.b2c_customer,
        b2c_alumnus:    @model.b2c_alumnus,
        b2c_apprentice: @model.b2c_apprentice,
        b2c_fellow:     @model.b2c_fellow,
        b2b_person:     @model.b2b_person,
        other:          @model.other,
        opt_in_uuid:    @model.random_opt_string,
        marketing_consent: marketing_consent?,
        date_consent_given: date_consent_given,
        hs_legal_basis: legal_basis,
        legal_basis: legal_basis
      }
    end

    def opt_in_traits
      {
        email: @model.email,
        marketing_consent: true,
        date_consent_given: "#{Time.now}",
        hs_legal_basis: "Freely given consent from contact",
        legal_basis: "Freely given consent from contact"
      }
    end

    def opt_out_traits
      {
        email: @model.email,
        marketing_consent: false,
        date_consent_given: nil,
        hs_legal_basis: "Not applicable",
        legal_basis: "Not applicable"
      }
    end

    def marketing_consent?
      @model.b2c_customer   ||
      @model.b2c_alumnus    ||
      @model.b2c_apprentice ||
      @model.b2c_fellow
    end

    def date_consent_given
      if marketing_consent?
        return "#{Time.now}"
      end
    end

    def legal_basis
      return "Legitimate interest - prospect/lead" if @model.b2b_person
      return "Legitimate interest - existing customer" if marketing_consent?
      return "Not applicable"
    end

    def error_message(status, msg)
      "Error: #{ @model.email } (#{ @model.name }), database ID #{ @model.id }. #{status}. #{msg}"
    end
  end
end