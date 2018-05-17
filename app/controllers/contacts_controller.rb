require "#{Rails.root}/lib/customerio/contact"

class ContactsController < ApplicationController
  def opt_in
    p params
    contact = Contact.find_by_random_opt_string(params["opt_in_uuid"])
    p contact
    @success = CustomerIO::Contact.new(contact).opt_in
  rescue
    redirect_to error_url
  end

  def opt_out
    p params
    contact = Contact.find_by_random_opt_string(params["opt_in_uuid"])
    p contact
    @success = CustomerIO::Contact.new(contact).opt_out
  rescue
    redirect_to error_url
  end

  def error
  end
end