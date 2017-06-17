class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.all.order(:lastname).page params[:page]
  end

  def show
  end

  def new
    @customer = Customer.new
  end

  def edit
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save(customer_params)
      redirect_to customer_path(@customer)
    else
      render :new
    end
  end

  def update
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def destroy
    if @customer.destroy
      flash[:success] = "#{@customer.firstname} #{@customer.lastname} has successfully been deleted from the system"
      redirect_to customers_path
    else
      flash[:error] = Unable to delete user
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
