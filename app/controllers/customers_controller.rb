class CustomersController < ApplicationController
  before_action :set_customer, only: %i[ show update destroy ]

  # GET /customers
  def index
    @customers = Customer.all

    render json: @customers
  end

  # GET /customers/1
  def show
    render json: @customer
  end

  # POST /customers
  def create
    @customer = Customer.new(customer_params)

    @customer.photo.attach(params[:photo]) if params[:photo].present?
    @customer.created_by_id = current_user.id
    @customer.updated_by_id = current_user.id

    if @customer.save
      render json: @customer, status: :created, location: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /customers/1
  def update
    @customer.updated_by_id = current_user.id
    @customer.photo.attach(params[:photo]) if params[:photo].present?
    if @customer.update(customer_params)
      render json: @customer
    else
      render json: @customer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /customers/1
  def destroy
    @customer.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_customer
      @customer = Customer.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def customer_params
      params.permit(:name, :surname, :cx_id, :photo_url)
    end
end
