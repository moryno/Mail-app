class AssessmentsController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    def create
        
        if @mentor
            assessment = Assessment.create(assessment_params.merge({mentor: @mentor}))
           
            if assessment.valid?
                render json: assessment, status: :created
            else
                render json: {error: "Failed to create assessment"}, status: :unprocessable_entity
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def index
      
         render json: Assessment.all, status: :ok
       
    end

    def show
        assessment = find_assessment

        if assessment
            render json: assessment, status: :ok
        else
            render_assessment_not_found_response
        end
    end

    def update
        if @mentor
            assessment = find_assessment
           
            if assessment
                assessment.update(assessment_params)
                render json: assessment, status: :accepted
            else
                render_assessment_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def destroy
        if @mentor
            assessment = find_assessment
           
            if assessment
                assessment.destroy
                render json: {}
            else
                render_assessment_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    private

    def assessment_params
        params.permit(:title, :duedate)
    end

    def find_assessment
        Assessment.find_by(id: params[:id])
    end

    def render_assessment_not_found_response
        render json: {error: "assessment is not available."}
    end
end
