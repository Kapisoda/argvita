class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  after_create :subscribe_user_to_mailing_list



  validates :name, :address, :state, :postcode, :phone, presence: true

  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.new.async.perform(self)
  end

  def send_welcome_email_to_user
    UserMailer.welcome_email(self).deliver_now
  end

end
