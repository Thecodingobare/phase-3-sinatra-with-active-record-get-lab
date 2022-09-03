class ApplicationController < Sinatra::Base

  # add routes
  set :default_content_type,'application/json'
    get '/bakeries' do
      bakeries = Bakery.all.to_json
      bakeries

end

  get '/bakeries/:id' do
    bakery = Bakery.find(params[:id])
    bakery.to_json(only: [:id, :name], include: {baked_goods: {only: [:id, :name, :price, :bakery_id]}})
    
  end

  get '/baked_goods/by_price' do 
    baked_goods = BakedGood.all.order(price: :desc)
    baked_goods.to_json(only: [:id, :name, :price])
  end

  # get('/baked_goods/most_expensive') do
  #   baked_goods = BakedGood.group(:name).maximum(:price).first
  #   baked_goods.to_json(only: [:name])

  get('/baked_goods/most_expensive') do
    baked_goods = BakedGood.all.order(price: :desc).first
    baked_goods.to_json
  end

end
