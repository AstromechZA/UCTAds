class Upload < ActiveRecord::Base
  belongs_to :advert

  has_attached_file :image, styles: {
    thumb: '100x100#',
    medium: '300x300#',
    original: '800x600>'
  }

  validates_attachment_content_type :image, :content_type => /^image\/(png|jpeg|jpg)/
end
