class Advert < ActiveRecord::Base
  belongs_to :category

  serialize :fieldvalues

  validates :title, presence: true, length: {minimum: 10}

  validate :fields_validation

  def fields_validation
    fieldsdef = category.nil? ? {} : category.build_fields_hash
    message, r = valid_fields(fieldsdef, fieldvalues)
    errors[:fieldvalues] << message unless r
  end

  def valid_fields(fieldsdef, fieldsval)
    # for each field definition
    fieldsdef.each_pair do |k,v|
      # if the field is in the values
      if fieldsval.include? k and fieldsval[k].present?
        if v.include? :select and not v[:select].include? fieldsval[k]
          return "'#{k}'' must be one of #{v.select}.", false
        end
      elsif not v[:optional]
        return "'#{k}' is required.", false
      end
    end
    return '', true
  end

end
