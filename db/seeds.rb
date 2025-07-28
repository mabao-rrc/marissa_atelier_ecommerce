# This file ensures the existence of records required to run the application
# in every environment (production, development, test). The code here is idempotent,
# meaning it can be safely run multiple times without creating duplicate data.
# You can run this file using: bin/rails db:seed

# --------------------------------------------------
# Create a default admin user for development
# --------------------------------------------------
# This account allows you to log into the ActiveAdmin dashboard at /admin
# Only created if the environment is development to avoid creating test accounts in production
if Rails.env.development?
  AdminUser.find_or_create_by!(email: 'admin@example.com') do |user|
    user.password = 'password'
    user.password_confirmation = 'password'
  end
end

# --------------------------------------------------
# Create static content pages: About and Contact
# --------------------------------------------------
# These are used for public-facing pages like /about and /contact
# They are editable from the ActiveAdmin dashboard under "Pages"
# Using find_or_create_by! ensures pages are not duplicated if the seed file is run again

Page.find_or_create_by!(slug: 'about') do |page|
  page.title = 'About Us'
  page.content = 'This is the About page. You can edit this content in ActiveAdmin.'
end

Page.find_or_create_by!(slug: 'contact') do |page|
  page.title = 'Contact Us'
  page.content = 'This is the Contact page. You can edit this content in ActiveAdmin.'
end
