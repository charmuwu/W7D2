class BandsController < ApplicationController
    def index
        @bands = Band.all
        render :index
    end

    def create
        @bands = Band.new(band_params)
        if @band.save
            redirect band_url
        else
            flash.new[:errors] = @band.errors.full_messages
            render plain: "ruh roh"
        end
    end

    def new
        @band = Band.new
        render plain: "yay"
    end

    def edit
        @band = Band.find_by(name: params[:name])
        render :edit
    end

    def show
        @band = Band.find(params[:name])
        render plain: "waow owen wilson"
    end

    def update
        band = Band.find(params[:name])

        if band.update(user_params)
            redirect_to band_url
        else
            render plain: "huh? where?"
        end
    end

    def destroy

    end
    private
    def band_params
        params.require(:band).permit(:name)
    end
end