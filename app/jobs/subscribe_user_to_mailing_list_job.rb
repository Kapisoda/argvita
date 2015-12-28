class SubscribeUserToMailingListJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    gibbon = Gibbon::Request.new
    gibbon.lists("7c95b280f7").members.create( body: {email_address: "foo@bar.com", status: "subscribed", merge_fields: {FNAME: "First Name", LNAME: "Last Name"}})
  end
end
