class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  # Pagination implemented via Kaminari gem, full reference documentation available here: https://github.com/kaminari/kaminari
  def index
    @customers = Customer.all.order(:lastname).page params[:page]
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save(customer_params)
      flash[:success] = "Customer has successfully been added to the system"
      redirect_to customer_path(@customer)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:success] = "Customer has successfully been updated"
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      flash[:success] = "Customer has successfully been deleted from the system"
      redirect_to customers_path
    else
      flash[:alert] = @customer.errors.full_messages.join(", ")
      redirect_to customers_path
    end
  end


  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:firstname, :lastname, :email, :avatar)
  end
end
