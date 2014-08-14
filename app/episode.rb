class Episode
  include BrickcasterHelpers

  def self.get podcast_id, episode_number
    Episode.new podcast_id, episode_number
  end

  def self.filename podcast_id, episode_number, format="md"
    'data/episodes/' + podcast_id + '/' + podcast_id + '_' + self.file_number(episode_number) + '.' + format
  end

  def self.file_number episode_number
    begin
      "%03d" % Integer(episode_number)
    rescue
      episode_number
    end
  end

  def initialize podcast_id, episode_number
    @podcast_id = podcast_id
    @episode_number = episode_number
    parse_file
  end

  def parse_file
    file_contents = File.read(Episode.filename(@podcast_id, @episode_number))
    if (md = file_contents.match(/^(?<metadata>---\s*\n.*?\n?)^(---\s*$\n?)/m))
      @body = markdown.render(md.post_match)
      @metadata = YAML.load(md[:metadata])
    end
  end

  def body
    @body
  end

  def body_truncate
    truncate(@body, :length => 255, :separator => "\n")
  end

  def summary
    @metadata["summary"]
  end

  def title
    @metadata["title"]
  end

  def url
    @metadata["url"]
  end

  def local_url
    url.gsub('http://brickcaster.com', '')
  end

  def media_url
    @metadata["media_url"]
  end

  def media_title
    @metadata["media_title"]
  end

  def media_album
    @metadata["media_album"]
  end

  def media_artist
    @metadata["media_artist"]
  end

  def media_length
    @metadata["media_length"]
  end

  def media_size
    @metadata["media_size"]
  end

  def publish_date
    @metadata["publish_date"]
  end

end
