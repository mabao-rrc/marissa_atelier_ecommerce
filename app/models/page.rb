class Page < ApplicationRecord
  validates :title, :slug, :content, presence: true
  validates :slug, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["id", "title", "slug", "content", "created_at", "updated_at"]
  end
end
