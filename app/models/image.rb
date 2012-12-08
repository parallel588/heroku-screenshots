class Image < ActiveRecord::Base
  SCREENSHOT_SCRIPT_PATH = File.join(Rails.root, 'lib', 'screenshot.js')
  PHANTOMJS_BIN = 'phantomjs'
  LAST_LIMIT = 5

  attr_accessible :image, :url
  after_create :screenshot!
  scope :last, ->{ limit(LAST_LIMIT).order("created_at DESC") }

  mount_uploader :image, ScreenshotImageUploader

  validates :url, presence: true, format: URI::regexp(%w(http https))

  def screenshot!
    unless image.present?
      begin
        png_file_path =  File.join(Rails.root, 'tmp', "#{Time.now.to_i}-#{self.id}.png")
        ph_commad = Cocaine::CommandLine.new(PHANTOMJS_BIN, ":script :in :out" )
        ph_commad.run(script: SCREENSHOT_SCRIPT_PATH, in: self.url,  out: png_file_path  )

        self.image = File.new(png_file_path)
        self.save!

      ensure
        FileUtils.rm_f(png_file_path)

      end
    end
  end

end
