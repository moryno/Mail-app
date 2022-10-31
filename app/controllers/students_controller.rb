class StudentsController < ApplicationController
    skip_before_action :authorized, only: [:register, :login]

    def register
       
        @student = Student.create(student_register_params);

       if @student.valid?
           
            render json: {student: StudentSerializer.new(@student)}, status: :created;
        else
            render json: {error: "student was not created"}, status: :unprocessable_entity
        end
    end

    def login
        @student = Student.find_by(username: student_login_params[:username]);

        if @student && @student.authenticate(student_login_params[:password])
            token = encode_token({student_id: @student.id}, Time.now.to_i + 432000);
            render json: {student: StudentSerializer.new(@student), token: token}, status: :ok;
        else
            render json: {error: "Invalid username or password"}, status: :unprocessable_entity
        end
    end

    private

  

    def student_register_params
        params.permit(:first_name, :last_name, :username, :email, :password, :role)
    end

    def student_login_params
        params.permit(:username, :password)
    end
end
