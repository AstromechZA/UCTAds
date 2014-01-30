class Category < ActiveRecord::Base
  acts_as_tree :order => 'name'

  serialize :fields

  validates :name, presence: true

  def build_fields_hash
    f = fields.nil? ? {} : fields
    ancestors.each do |a|
      f = a.fields.merge(f)
    end
    return f
  end


end
