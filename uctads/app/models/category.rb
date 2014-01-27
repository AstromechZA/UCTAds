class Category < ActiveRecord::Base
  has_many :children, class_name: 'Category', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Category'
  serialize :fields

  validates :name, presence: true


  def build_fields_hash
    p = parent.nil? ? {} : parent.build_fields_hash
    f = fields.nil? ? {} : fields
    return p.merge(f)
  end


end
