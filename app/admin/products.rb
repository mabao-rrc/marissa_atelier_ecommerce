# app/admin/products.rb

ActiveAdmin.register Product do
  permit_params :name, :description, :price, :stock_quantity, :image_url, category_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :stock_quantity
    column :image_url
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :price
      row :stock_quantity
      row :image_url
      row :categories do |product|
        product.categories.pluck(:name).join(', ')
      end
    end
  end

  form do |f|
    f.semantic_errors

    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock_quantity
      f.input :image_url
      f.input :categories, as: :check_boxes, collection: Category.all
    end

    f.actions
  end
end
