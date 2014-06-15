class Advert < ActiveRecord::Base
  belongs_to :category
  has_many :uploads

  serialize :fieldvalues, Hash

  validate :title_must_be_valid, :description_must_be_valid, :all_fields_must_match_fielddefs, :price_must_be_valid

  PRICE_TYPES = {'exact' => 'Exact Price', 'poa' => 'On Application', 'swap' => 'To Swap', 'free' => 'Free'}

  # -- model validation

  def title_must_be_valid
    if not title.present?
      errors.add(:title, 'Advert title cannot be blank')
    elsif title.length < 5 or title.length > 60
      errors.add(:title, 'Advert title must be between 5 and 60 characters')
    end
  end

  def description_must_be_valid
    if not description.present?
      errors.add(:description, 'Advert must have a description')
    elsif description.length < 10 or description.length > 10000
      errors.add(:description, 'Advert description must be longer than 10 characters')
    end
  end

  def all_fields_must_match_fielddefs
    fielddefs = category.self_and_ancestors.map {|p| p.fields}.inject {|a,b| a.merge!(b)}

    # check extra fields
    extras = fieldvalues.keys - fielddefs.keys
    if not extras.empty?
      errors.add(:fieldvalues, "Unknown fields (#{extras.join(', ')})")
    end

    fielddefs.each_pair do |name, options|
      if fieldvalues.include? name and fieldvalues[name].present?
        if options.include? :select and not options[:select].include? fieldvalues[name]
          errors.add(:fieldvalues, "Field '#{name}' must be one of #{options[:select].join(', ')}")
        end
      elsif not options[:optional]
        errors.add(:fieldvalues, "Field '#{name}' is required")
      end
    end
  end

  def price_must_be_valid
    if not PRICE_TYPES.include? price_type
      errors.add(:price_type, "Price type #{price_type} is invalid")
    end
    if price_type == 'exact' and (price.nil? or price < 0.00 or price > 99999999.99)
      errors.add(:price, "Price value '#{price}' is out of the allowed range")
    end
  end

end
