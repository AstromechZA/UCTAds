class Category < ActiveRecord::Base
  acts_as_tree :order => 'name'

  serialize :fields

  validates :name, presence: {message: 'Category name cannot be blank'}
  validate :cant_have_dupl_name

  def build_fields_hash
    f = fields.nil? ? {} : fields
    ancestors.each do |a|
      f = a.fields.merge(f)
    end
    return f
  end

  def cant_have_dupl_name
    if not siblings.index {|s| s.name == name}.nil?
      errors.add(:name, 'Name conflicts with an adjacent category in the tree')
    end
  end

end
