class Upload < ActiveRecord::Base
  belongs_to :advert

  has_attached_file :image, styles: {
    thumb: '100x100#',
    medium: '300x300#',
    original: '800x600>'
  }

  validates_attachment_content_type :image, :content_type => /^image\/(png|jpeg|jpg)/
  validates :image, presence: true
  validates :advert, presence: true
  validate :max_uploads_per_advert

  @@MAX_PER_ADVERT = 10
  def self.MAX_PER_ADVERT
    @@MAX_PER_ADVERT
  end

  def max_uploads_per_advert
    if advert.uploads.length > @@MAX_PER_ADVERT
        errors.add(:advert, "has too many images")
    end
  end


end
