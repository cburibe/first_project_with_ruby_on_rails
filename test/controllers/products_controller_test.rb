require 'test_helper'
class ProductsControllerTest < ActionDispatch::IntegrationTest
  test'render a list all products' do
    get products_path
    assert_response :success
    assert_select '.product', 2
  end

  test 'render a detailed product page' do
    get product_path(products(:crack))
    assert_response :success
    assert_select '.title', 'galleta de choco'
    assert_select '.description', 'excelente galleta'
    assert_select '.price', '123'
  end
  test 'render new product' do
    get new_product_path
    assert_response :success
    assert_select 'form'
  end
  test 'allow to create a new product' do
    post products_path, params:{
      product:{
        title: 'Hola',
        description: 'ajksdmakmsd',
        price: 23
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto se ha creado correctamente'
  end
  test 'does not allow to create a new product to empty field' do
    post products_path, params:{
      product:{
        title: '',
        description: 'ajksdmakmsd',
        price: 23
      }
    }
    assert_response :unprocessable_entity
  end
  test 'render an edit product' do
    get edit_product_path(products(:crack))
    assert_response :success
    assert_select 'form'
  end

  test 'allow to update a product' do
    patch product_path(products(:crack)), params:{
      product:{
        price: 165
      }
    }
    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto ha sido editado correctamente'
  end

  test 'does not allow to update a product when a field is nil' do
    patch product_path(products(:crack)), params:{
      product:{
        price: nil
      }
    }
    assert_response :unprocessable_entity
  end
  test 'can delete product' do
    assert_difference('Product.count' -1) do
      delete product_path(products(:crack))
    end

    assert_redirected_to products_path
    assert_equal flash[:notice], 'Tu producto ha sido eliminado correctamente'
  end

end