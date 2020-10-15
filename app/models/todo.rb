class Todo < ApplicationRecord
  # validates :name, presence: true
  # validates :description, presence: true

  def self.matches(field_name, param) 
    where("#{field_name} like ?", "%#{param}%")
  end

  def self.search(param)
    param.strip!
    to_send_back = (name_matches(param) + description_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end

  def self.name_matches(param)
    matches('name', param)
  end

  def self.description_matches(param)
    matches('description', param)
  end

end

def self.search(param) 
  param.strip!
  to_send_back = (name_matches(param) + description_matches(param)).uniq
end

