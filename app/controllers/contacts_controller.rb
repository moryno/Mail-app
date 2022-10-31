class ContactsController < ApplicationController
  skip_before_action :authorized, only: [:create]
    def create
     @contact = Contact.new(params[:contact])
    
     @contact.request = request
     if @contact.deliver
       render json: {message: "Assessment has been created and email has been sent successfully."}
     else
       render json: {message: "Error occured. Please try again!"}
     end
    end

    private
    def secure_params
      params.permit(:title, :duedate)
    end
end