class Plant < ApplicationRecord
  belongs_to :user
  belongs_to :bed
  has_many :harvests
  accepts_nested_attributes_for :bed, reject_if: :all_blank
  validates :variety, presence: true

  scope :been_harvested, -> { where(harvested: true) }
  scope :alpha_sort, -> {(self.all.order(variety: :asc))} #replace this scope with scope below
  scope :sorted_by_name, -> {(self.all.order(variety: :asc))}
  scope :sorted_by_germination_date, -> {(self.all.order(germination_date: :asc))}

  def harvest_status
    unless self.harvests.count == 0
    self.harvested = true
    self.save
    end
  end

  def yield_amount
    amount = 0
    if self.harvests.count > 0
      self.harvests.each {|harvest| amount +=  harvest.weight}
    end
    amount
  end
  
end
