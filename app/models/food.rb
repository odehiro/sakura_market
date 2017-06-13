class Food < ApplicationRecord
  before_create :add_order
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

    def add_order
      if !self.order
        if Food.all.count == 0
          self.order = 1
        else
          max = Food.maximum("order") 
          #debugger
          self.order =  max + 1
        end
      end
    end
end
