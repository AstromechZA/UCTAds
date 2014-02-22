class Category < ActiveRecord::Base
  acts_as_tree :order => 'name'

  serialize :fields, Hash

  validates :name, presence: {message: 'Category name cannot be blank'}
  validate :cant_have_dupl_name, :cant_have_conflicting_fields

  def build_fields_hash
    f = fields.nil? ? {} : fields
    ancestors.each do |a|
      f = a.fields.merge(f)
    end
    return f
  end

  def cant_have_dupl_name
    if siblings.index {|s| s.name == name}
      errors.add(:name, 'Name conflicts with an adjacent category in the tree!')
    end
  end

  def cant_have_conflicting_fields
    # duplicate field names
    dups = fields.keys - fields.keys.uniq
    if not dups.empty?
      errors.add(:fields, "Duplicate field names! (#{dups.join(' ')})")
    end

    # test ancestor fields
    conflicts = ancestors.map {|a| a.fields.keys}.flatten & fields.keys
    if not conflicts.empty?
      errors.add(:fields, "Fields conflict with parent fields! (#{conflicts.join(' ')})")
    end

    # test descendants fields
    descendants.each do |d|
      conflicts = d.fields.keys & fields.keys
      if not conflicts.empty?
        errors.add(:fields, "Fields (#{conflicts.join(' ')}) conflict with descendant #{d.name}")
      end
    end
  end

end
