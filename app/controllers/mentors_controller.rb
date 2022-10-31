class MentorsController < ApplicationController
    def show
        if @mentor
            current_mentor = find_mentor
            if current_mentor
                render json: current_mentor, status: :ok
            else
                render_user_not_found_response
            end
        else
            render json: {error: "Only admin is authorized to do that!"}
        end
     end

     private
   
     def find_mentor
      Mentor.find_by(id: params[:id])
     end
end
