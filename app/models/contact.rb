class Contact < MailForm::Base
    attribute :title,      :validate => true
    # attribute :email,     :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
    attribute :duedate
    attribute :nickname,  :captcha  => true
  
    # Declare the e-mail headers. It accepts anything the mail method
    # in ActionMailer accepts.
    def headers
     full_name = "#{Mentor.first.first_name} #{Mentor.first.last_name}"
    
     email = Mentor.first.email
      {
        :subject => "You have been invited to take on the assessment",
        :to => "mauricenganga41@gmail.com",
        :cc => "moryno8626@gmail.com",
        :from => %("#{full_name}" <#{email}>)
      }
    end
  end
  