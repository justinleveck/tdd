class Person < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :company_name, :email
  has_many :notes

  def self.merge(winner, loser)
    winner.notes << loser.notes
    winner.email = loser.email
    loser.destroy
    winner
  end

  def duplicates?(other)
    return false if other.nil?
    comparison_hash == other.comparison_hash
  end

  def comparison_hash
    self.attributes.select { |attribute, value| ['first_name', 'last_name', 'email'].include? attribute.to_str }
  end
end