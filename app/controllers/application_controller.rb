class ApplicationController < ActionController::API
    before_action :authorized

    def encode_token(payload, expiration)
        payload[:exp] = expiration
        JWT.encode(payload, "secret")
    end

    def decode_token
        auth_header = request.headers["Authorization"];
  \
        if auth_header
            token = auth_header.split(" ")[1]
            begin
                JWT.decode(token, "secret", algorithm: "HS256")
            rescue JWT::DecodeError
                nil
            end
        end
    end

    def authorize_user
        if decode_token
            if decode_token[0]["mentor_id"]
                mentor_id = decode_token[0]["mentor_id"]
                @mentor = Mentor.find_by(id: mentor_id)
            else
                student_id = decode_token[0]["student_id"]
                @student = Student.find_by(id: student_id)
            end 
        end
    end

    def authorized
        render json: {message: "You have to log in."}, status: :unauthorized unless authorize_user
    end

    private

    


end
