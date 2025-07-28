# app/admin/pages.rb

ActiveAdmin.register Page do
  # Only allow these fields to be updated
  permit_params :title, :slug, :content

  # Show basic columns in the index page
  index do
    selectable_column
    id_column
    column :title
    column :slug
    actions
  end

  # Form for editing the page content
  form do |f|
    f.inputs "Edit Page Content" do
      f.input :title
      f.input :slug, input_html: { disabled: true } # prevent accidental slug changes
      f.input :content, as: :quill_editor # you can change this to :text if Quill isn’t installed
    end
    f.actions
  end
end
