class Drawing < ActiveRecord::Base
	belongs_to :user
	has_attached_file :photo,
	    #:styles => {:thumb => '50x50', :square => '200x200' },
      :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
      :url => "/system/:attachment/:id/:style/:filename"

  validates_attachment_presence :photo
	validates_attachment_size :photo, :less_than => 5.megabytes
	validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png' , 'image/jpg']
                    

  # def gen_screenshot!
  #   shot = ScreenShot.new(url, '200x200')
  #   self.screenshot = open(shot.img_url)
  #   save!
  # end
  def screenshot
    # require 'phantomjs'
    ws.capture("http://www.google.com/", "google.png") do |magick|
    magick.combine_options do |c|
    c.thumbnail "100x"
    c.background "white"
    c.extent "100x90"
    c.gravity "north"
    c.quality 85
    end
  end
end

  # site = Website.new(url: 'http://reddit.com')
  # site.gen_screenshot!

end
