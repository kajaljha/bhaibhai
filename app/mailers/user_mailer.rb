class UserMailer < ApplicationMailer
  def user_feedback(feedback)
    @user = feedback
    mail(to: "bhaskar.affimintus@gmail.com", subject: "Feedback Email")
  end
end