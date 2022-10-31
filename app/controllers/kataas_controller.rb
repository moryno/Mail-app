class KataasController < ApplicationController
    skip_before_action :authorized, only: [:index, :show]

    def create
        if @mentor
            kataa = Kataa.create(kataa_params)
           
            if kataa.valid?
                render json: kataa, status: :created
            else
                render json: {error: "Failed to create kataa"}, status: :unprocessable_entity
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def index
      
         render json: Kataa.all, status: :ok
       
    end

    def show
        kataa = find_kataa

        if kataa
            render json: kataa, status: :ok
        else
            render_kataa_not_found_response
        end
    end

    def update
        if @mentor
            kataa = find_kataa
           
            if kataa
                kataa.update(kataa_params)
                render json: kataa, status: :accepted
            else
                render_kataa_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    def destroy
        if @mentor
            kataa = find_kataa
           
            if kataa
                kataa.destroy
                render json: {}
            else
                render_kataa_not_found_response
            end
        else
            render json: {error: "Only mentor is authorized to do that!"}
        end
    end

    private

    def kataa_params
        params.permit(:question, :instructions, :answer)
    end

    def find_kataa
        Kataa.find_by(id: params[:id])
    end

    def render_kataa_not_found_response
        render json: {error: "kataa is not available."}
    end
end
