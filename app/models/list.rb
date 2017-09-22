class List < ApplicationRecord
  validates :user_id, :description, :date_pay, :cost, :target_account, presence:{message:"This atributte can't be empty"}
  validates :user_id, numericality: {:greater_than => 0,message: "Must be greater than 0"}
  validates :target_account, numericality: {:greater_than => 0,message: "Must be greater than 0"}
  validates :cost, numericality: {:greater_than => 0,message: "Must be greater than 0"}

  def self.by_user(user)
    self.all.where(user_id: user)
  end

end
