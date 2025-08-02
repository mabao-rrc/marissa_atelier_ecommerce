# This file ensures the existence of records required to run the application
# in every environment (production, development, test). The code here is idempotent,
# meaning it can be safely run multiple times without creating duplicate data.
# You can run this file using: bin/rails db:seed

# --------------------------------------------------
# Create a default admin user for development
# --------------------------------------------------
if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

# --------------------------------------------------
# Create static content pages: About and Contact
# --------------------------------------------------
Page.find_or_create_by!(slug: 'about') do |page|
  page.title = 'About Us'
  page.content = 'This is the About page. You can edit this content in ActiveAdmin.'
end

Page.find_or_create_by!(slug: 'contact') do |page|
  page.title = 'Contact Us'
  page.content = 'This is the Contact page. You can edit this content in ActiveAdmin.'
end

# --------------------------------------------------
# Create categories
# --------------------------------------------------
Category.destroy_all
category_records = {
  "Earrings" => Category.create!(name: "Earrings"),
  "Necklaces" => Category.create!(name: "Necklaces"),
  "Bracelets" => Category.create!(name: "Bracelets"),
  "Rings" => Category.create!(name: "Rings")
}

# --------------------------------------------------
# Create jewelry products with real filenames
# --------------------------------------------------
Product.destroy_all

products_data = [
  { name: "Aurea Petal Drop Earrings", filename: "aurea_petal_drop_earrings", category: "Earrings", price: 110, stock: 10 },
  { name: "Aurora Link Bracelet", filename: "aurora_link_bracelet", category: "Bracelets", price: 125, stock: 6 },
  { name: "Celeste Pearl Stud Earrings", filename: "celeste_pearl_stud_earrings", category: "Earrings", price: 98, stock: 12 },
  { name: "Eira Wave Drop Earrings", filename: "eira_wave_drop_earrings", category: "Earrings", price: 120, stock: 8 },
  { name: "Elara Chain Necklace", filename: "elara_chain_necklace", category: "Necklaces", price: 145, stock: 5 },
  { name: "Luna Bold Hoop Earrings", filename: "luna_bold_hoop_earrings", category: "Earrings", price: 115, stock: 9 },
  { name: "Lyra Loop Stud Earrings", filename: "lyra_loop_stud_earrings", category: "Earrings", price: 105, stock: 10 },
  { name: "Mira Shell Stud Earrings", filename: "mira_shell_stud_earrings", category: "Earrings", price: 100, stock: 7 },
  { name: "Noor Flat Chain Necklace", filename: "noor_flat_chain_necklace", category: "Necklaces", price: 150, stock: 4 },
  { name: "Seren Stone Ring", filename: "seren_stone_ring", category: "Rings", price: 130, stock: 6 },
  { name: "Soleil Link Drop Earrings", filename: "soleil_link_drop_earrings", category: "Earrings", price: 118, stock: 11 },
  { name: "Vita Twist Hoop Earrings", filename: "vita_twist_hoop_earrings", category: "Earrings", price: 112, stock: 10 }
]

products_data.each do |data|
  Product.create!(
    name: data[:name],
    description: "#{data[:name]} — hand-finished and designed for timeless elegance.",
    price: data[:price],
    stock_quantity: data[:stock],
    image_url: "/uploads/products/#{data[:filename]}.png",
    categories: [category_records[data[:category]]]
  )
end
