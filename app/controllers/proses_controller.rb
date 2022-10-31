class ProsesController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    def create
        if @mentor
            prose = Prose.create(prose_params)
           
            if prose.valid?
                render json: prose, status: :created
            else
                render json: {error: "Failed to create prose"}, status: :unprocessable_entity
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def index
      
         render json: Prose.all, status: :ok
       
    end

    def show
        prose = find_prose

        if prose
            render json: prose, status: :ok
        else
            render_prose_not_found_response
        end
    end

    def update
        if @mentor
            prose = find_prose
           
            if prose
                prose.update(prose_params)
                render json: prose, status: :accepted
            else
                render_prose_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def destroy
        if @mentor
            prose = find_prose
           
            if prose
                prose.destroy
                render json: {}
            else
                render_prose_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    private

    def prose_params
        params.permit(:question, :instructions, :answer)
    end

    def find_prose
        Prose.find_by(id: params[:id])
    end

    def render_prose_not_found_response
        render json: {error: "prose is not available."}
    end
end
