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
