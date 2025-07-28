# app/admin/categories.rb

ActiveAdmin.register Category do
  permit_params :name

  index do
    selectable_column
    id_column
    column :name
    column :created_at
    actions
  end

  form do |f|
    f.inputs 'Category Details' do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :created_at
      row :updated_at
    end
  end
end
