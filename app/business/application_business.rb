class ApplicationBusiness
  def to_sort_title(title)
    sort_title = title.gsub(/^(The)\s+(.+)/) {|w| "#{$2}"}
    sort_title.downcase
  end
end