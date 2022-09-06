class ProductsController < ApplicationController
  def index
    @products = Product.all

    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; filename="products.xlsx"'
      }
    end
  end

  def show
    product
  end

  def new
    @product = Product.new
  end

  def create
    product

    if @product.save
      redirect_to products_path, notice: t('.created')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    product
  end

  def add_product

  end

  def upload
    require 'roo'
    uploaded_file = params[:file].path

    if upload_products(uploaded_file)
      redirect_to products_path, notice: 'Tus productos han sido guardados correctamente'
    else
      render :add_product, status: :unprocessable_entity, alert: 'No se ha podido guardar los productos'
    end
  end

  def update
    product

    if product.update(product_params)
      redirect_to products_path, notice: 'Tu producto ha sido editado correctamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    product
    @product.destroy

    redirect_to products_path, notice: 'Tu producto ha sido eliminado correctamente', status: :see_other
  end

  private

  def product_params
    params.require(:product).permit(:title, :description, :price)
  end

  def product
    @product = Product.find(params[:id])
  end

  def upload_products(path)
    data = Roo::Spreadsheet.open(path)
    headers = data.row(1)
    data.each_with_index do |row, idx|
      next if idx == 0
      product_data = Hash[[headers, row].transpose]
      if Product.exists?(description: product_data['description'])
        puts "Product with description #{product_data['description']} already exists"
        next
      end
      product_e = Product.new(product_data)
      puts "Saving Product with description '#{product_e.description}'"
      product_e.save!
    end

  end

end

# renombrar funcion control+t
# Por convención siempre debe ser con mayuscula el nombre del controlador
# Al declarar el nombre de la clase debe ser en CamelCase
# Todos nuestros controladores deben heredar de ApplicationController