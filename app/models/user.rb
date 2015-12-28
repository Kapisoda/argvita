class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable


  def after_confirmation
    subscribe_user_to_mailing_list
  end


  private

  def subscribe_user_to_mailing_list
    SubscribeUserToMailingListJob.perform_later(self)
  end

end
