require 'grape'

require 'catalog_service/product_repo'

# ick
$global_product_repo = CatalogService::ProductRepo.from_yaml(File.expand_path("../../../data/products.yaml",__FILE__))

module CatalogService
  class API < Grape::API
   format :json

    helpers do
      def product_repo
        $global_product_repo
      end
    end

    get '/products/:sku' do
      product = product_repo.lookup_by_sku(params[:sku])
      if product
        product
      else
        error!('Product not found', 404)
      end
    end
  end
end
