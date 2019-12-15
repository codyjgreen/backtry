module Api::V1
  class TrainsController < ApplicationController

    before_action :find_train, only: [:show, :edit, :update, :destroy]

    def index
      trains = Train.all
      render json: { message: "Trains successfully returned.", success: true, data: trains }, status: 200
    end

    def show
      # find_train
      if @train.nil?
        puts "Train not found"
        render json: { message: "Train NOT found.", success: false }, status: 406
      else
        puts "success"
        render json: { message: "Train successfully returned.", success: true, data: @train }, status: 200
      end
    end

    def new
    end

    def create
      byebug
      @train = Train.new(train_params)
      # if @train.nil?
      #   puts "Train not found"
      # end
      if @train.save && @train.valid?
        puts "train saved"
        render json: { message: "Train successfully saved.", success: true, data: @train }, status: 200
      else
        puts "Train not saved"
        puts "Errors= #{@train.errors.full_messages}"
        render json: { message: "Train NOT saved because #{@train.errors.full_messages}", success: false }, status: 406
      end
    end
        
    def edit
      # find_train
    end

    def update
      # find_train
      if @train.nil?
        puts "Train not found"
        render json: { message: "Train not found", success: false }, status: 406
      end
      if @train.update(train_params) && @train.valid?
        puts "train saved"
        render json: { message: "Train successfully saved.", success: true, data: @train }, status: 200
      else
        puts "Train not saved"
        puts @train.errors.full_messages
        render json: { message: "Train NOT updated because #{@train.errors.full_messages}", success: false }, status: 406
      end
    end

    def destroy
      # find_train
      if @train.destroy
        render json: { message: "Train successfully deleted.", success: true, data: @train }, status: 200
      else
        puts "Error in delete: #{@train.errors.full_messages}"
        puts @train.errors.full_messages
        render json: { message: "Train NOT successfully deleted.", success:false, data: @train.errors.full_messages }, status: 406
      end
    end

    private

    def find_train
      @train = Train.find_by(id: params[:id])
    end

    def train_params
      params.require(:train).permit(:destination, :newtime, :newtime24, :origin, :remarks_boarding, :scheduled, :scheduled24, :service, :trainno)
    end

  end
end