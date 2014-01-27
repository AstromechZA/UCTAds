class Category < ActiveRecord::Base
    has_many :children, class_name: 'Category', foreign_key: 'parent_id'
    belongs_to :parent, class_name: 'Category'

    validates :name, presence: true
    validates :fields, format: {
        with: /\A([A-Za-z\s]+(\|[A-Za-z\s]+)*)?\z/,
        message: "Only allows letters and spaces, separated by '|'"
    }

    def calculate_field_names
        f = fields.blank? ? [] : fields.split('|').collect {|s| s.strip}
        p = parent.nil? ? [] : parent.calculate_field_names
        return p + f
    end
end
