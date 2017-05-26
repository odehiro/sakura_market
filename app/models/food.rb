class Food < ApplicationRecord
  before_destroy :ensure_not_referenced_by_item
  
  has_many :line_items

  validates :name, presence: true
  validates :price, presence: true
  validates :caption, presence: true
  
  private
    def ensure_not_referenced_by_item
      if !line_items.empty?
        errors.add(:base, '品目が存在します')
        throw(:abort)
      end
    end
end
