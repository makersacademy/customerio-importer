module CustomerIO
  class Contact
    def initialize(model, analytics)
      @model = model
      @analytics = analytics
    end

    def sync
      @analytics.identify(@model.email, { traits: analytics_traits })
    end

    private

    def analytics_traits
      {
        email:          @model.email,
        first_name:     @model.first_name,
        last_name:      @model.last_name,
        b2c_customer:   @model.b2c_customer,
        b2c_alumnus:    @model.b2c_alumnus,
        b2c_apprentice: @model.b2c_apprentice,
        b2c_fellow:     @model.b2c_fellow,
        b2b_person:     @model.b2b_person,
        other:          @model.other,
        marketing_consent_given: marketing_consent_given?,
      }
    end

    def marketing_consent_given?
      @model.b2c_customer   ||
      @model.b2c_alumnus    ||
      @model.b2c_apprentice ||
      @model.b2c_fellow
    end
  end
end