class Admin::CustomersController < AdminController
  before_action :set_customer, only: %i[show destroy]

  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result
  end

  def show;end

  def destroy
    @customer.destroy
    redirect_to admin_customers_path, notice: 'Customer deleted successfully'
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end
end