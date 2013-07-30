module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Solution ADN"
    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end

  def youtube_embed(youtube_url)
    if youtube_url[/youtu\.be\/([^\?]*)/]
      youtube_id = $1
    else
      # Regex from # http://stackoverflow.com/questions/3452546/javascript-regex-how-to-get-youtube-video-id-from-url/4811367#4811367
      youtube_url[/^.*((v\/)|(embed\/)|(watch\?))\??v?=?([^\&\?]*).*/]
      youtube_id = $5
    end

    %Q{<iframe title="YouTube video player" width="315" height="200" src="http://www.youtube.com/embed/#{ youtube_id }" frameborder="0" allowfullscreen></iframe>}
  end
  
  def is_athlete(sessionid)
    return ("athlete".eql? sessionid) || ("all".eql? sessionid)
  end

  def is_admin(sessionid)
    return ("admin".eql? sessionid) || ("all".eql? sessionid)
  end

  def is_trainer(sessionid)
    return ("trainer".eql? sessionid) || ("all".eql? sessionid)
  end

  def is_professional(sessionid)
    return ("professional".eql? sessionid) || ("all".eql? sessionid);
  end

  def is_director(sessionid)
    return ("director".eql? sessionid) || ("all".eql? sessionid);;
  end
end
