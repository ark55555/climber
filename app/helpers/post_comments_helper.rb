module PostCommentsHelper

  def sentiment(score)
    if score.nil?
      ""
    elsif score >= 0.5
      content_tag(:i, "", class: "far fa-grin-hearts")
    elsif score < 0.5 && score >= 0
      content_tag(:i, "", class: "far fa-smile")
    elsif score < 0 && score >= -0.5
      content_tag(:i, "", class: "far fa-frown")
    else
      content_tag(:i, "", class: "far fa-dizzy")
    end
  end

end
