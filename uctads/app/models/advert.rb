class Advert < ActiveRecord::Base
  belongs_to :category

  serialize :fieldvalues, Hash

  validate :title_must_be_valid, :description_must_be_valid, :all_fields_must_match_fielddefs

  # -- model validation

  def title_must_be_valid
    if not title.present?
      errors.add(:title, 'Advert title cannot be blank')
    elsif title.length < 10 or title.length > 60
      errors.add(:title, 'Advert title must be between 10 and 60 characters')
    end
  end

  def description_must_be_valid
    if not description.present?
      errors.add(:description, 'Advert description must be valid')
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

end
