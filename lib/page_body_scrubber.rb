class PageBodyScrubber < Rails::Html::PermitScrubber
  def allowed_node?(node)
    !%w(div p a img form label input textarea select option button span script style iframe embed blockquote strong b em i u span hr br ul ol li table tr th td).include?(node.name)
  end

  def skip_node?(node)
    node.text?
  end
end
