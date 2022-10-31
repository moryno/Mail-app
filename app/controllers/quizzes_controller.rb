class QuizzesController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    def create
        if @mentor
            quiz = Quiz.create(quiz_params)
           
            if quiz.valid?
                render json: quiz, status: :created
            else
                render json: {error: "Failed to create quiz"}, status: :unprocessable_entity
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def index
      
         render json: Quiz.all, status: :ok
       
    end

    def show
        quiz = find_quiz

        if quiz
            render json: quiz, status: :ok
        else
            render_quiz_not_found_response
        end
    end

    def update
        if @mentor
            quiz = find_quiz
           
            if quiz
                quiz.update(quiz_params)
                render json: quiz, status: :accepted
            else
                render_quiz_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def destroy
        if @mentor
            quiz = find_quiz
           
            if quiz
                quiz.destroy
                render json: {}
            else
                render_quiz_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    private

    def quiz_params
        params.permit(:question, {:answers => []}, :correct_answer, :assessment_id, :time_limit)
    end

    def find_quiz
        Quiz.find_by(id: params[:id])
    end

    def render_quiz_not_found_response
        render json: {error: "quiz is not available."}
    end
end
