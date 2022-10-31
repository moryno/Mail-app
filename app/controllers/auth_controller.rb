class AuthController < ApplicationController
    skip_before_action :authorized, only: [:register, :login]

    def register
        @mentor = Mentor.create(mentor_register_params);

        if @mentor.valid?
           
            render json: {mentor: MentorSerializer.new(@mentor)}, status: :created;
        else
            render json: {error: "Mentor was not created"}, status: :unprocessable_entity
        end
    end

    def login
        @mentor = Mentor.find_by(work_id: mentor_login_params[:work_id])

        if @mentor && @mentor.authenticate(mentor_login_params[:password])
            token = encode_token({mentor_id: @mentor.id}, Time.now.to_i + 432000);
            render json: {mentor: MentorSerializer.new(@mentor), token: token}, status: :ok;
        else
            render json: {error: "Invalid username or password"}, status: :unprocessable_entity
        end
    end

    private

    def mentor_register_params
        params.permit(:first_name, :last_name, :work_id, :email, :password, :role)
    end

    def mentor_login_params
        params.permit(:work_id, :password)
    end
    
end
