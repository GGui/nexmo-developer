class Session < ApplicationRecord
  belongs_to :event

  validates :title, presence: true
  validates :author, presence: true
  validates :event, presence: true
  validates :video_url, presence: true

  def video_content
    video_id = video_url.gsub('https://www.youtube.com/watch?v=', '')
    <<~HEREDOC
      <div class="video">
        <iframe src="#{embed_url}" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
      </div>
    HEREDOC
  end

  private

  def embed_url
    if video_url.include? 'youtube'
      video_id = video_url.match(/v=(.{11})/)[1]
      return "https://www.youtube.com/embed/#{video_id}?showinfo=0"
    end

    if video_url.include? 'vimeo'
      video_id = video_url.match(/(\d{7})/)[1]
      return "https://player.vimeo.com/video/#{video_id}"
    end
  end
end