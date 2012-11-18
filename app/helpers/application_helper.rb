module ApplicationHelper
  def m_ss(secs)
    "%d:%02d" % secs.divmod(60)
  end

  def mm_ss(secs)
    "%02d:%02d" % secs.divmod(60)
  end

  def h_ss(mins)
    "%d:%02d" % mins.divmod(60)
  end

  def partial_name(partial)
    puts "checking #{partial} #{controller_name}"
    if lookup_context.template_exists? partial + '.foo', controller_name, true
      partial + '.foo'
    else
      partial
    end
  end
end
