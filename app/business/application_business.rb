class ApplicationBusiness
  def to_sort_title(title)
    sort_title = title.gsub(/^(The)\s+(.+)/) {|w| "#{$2}"}
    sort_title.downcase
  end

  def to_sort_name(name)
    if name =~ /^(\S+)\s+(\S+)$/
      "#{$2}, #{$1}"
    elsif name =~ /^(\S+)\s+(\S+)\s+(\S+)$/
      if $2.length == 2 and $2.ends_with? '.'
        "#{$3}, #{$1} #{$2}"
      else
        "#{$2} #{$3}, #{$1}"
      end
    else
      name
    end
  end
end