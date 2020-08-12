module ApplicationHelper

  include Pagy::Frontend

  def calc_stats(data)
    results = { mean: 0, min: 0, max: 0, std_dev: 0 }
    return results if data.size == 0
    sum = data.sum
    results[:mean] = sum / data.size.to_f
    results[:min] = data.min
    results[:max] = data.max
    sum_squared_diffs = 0.0
    data.each {|d| sum_squared_diffs += (d - results[:mean])**2 }
    variance = sum_squared_diffs / data.size.to_f
    results[:std_dev] = Math.sqrt(variance)
    return results
  end

  def clear_filter_link(filter, label)
    symbol = filter.to_sym
    return if params[symbol].blank?
    value = params[symbol]
    case symbol
    when :with_operator
      value = User.find(params[symbol]).number_and_name
    when :with_rework
      case params[symbol]
      when '1'
        value = 'Only Rework'
      when '2'
        value = 'Exclude Rework'
      end
    when :with_early
      case params[symbol]
      when '1'
        value = 'Only Early Checks'
      when '2'
        value = 'Exclude Early Checks'
      end
    when :with_strip
      case params[symbol]
      when '1'
        value = 'Only Strip Checks'
      when '2'
        value = 'Exclude Strip Checks'
      end
    end
    link_to "<i class=\"fas fa-times-circle\"></i> #{label}: <code>#{value}</code>".html_safe, reset_filter_blocks_url(filter: symbol), class: ["badge", "badge-warning", "p-2", "ml-2", "mt-2"]
  end

  def required_field_indicator
    "<sup class=\"text-danger\"><small><i class=\"fas fa-asterisk\"></i></small></sup>"
  end

  def part_spec(block)
    fields = []
    fields << link_to(block.customer_code, request.params.merge({with_customer: block.customer_code}))
    fields << link_to(block.process_code, request.params.merge({with_process: block.process_code}))
    fields << link_to(block.part_number, request.params.merge({with_part: block.part_number}))
    fields << link_to(block.part_sub, request.params.merge({with_sub: block.part_sub})) unless block.part_sub.blank?
    "<span class=\"part-spec\">#{fields.join(" <span>/</span> ")}</span>".html_safe
  end

  def load_with_badges(block)
    "<span class=\"value\">#{link_to block.load, request.params.merge({with_load: block.load})}</span> #{load_badges(block)}".html_safe
  end

  def load_badges(block)
    badges = []
    badges << "<small class=\"load-badge text-danger\">RW</small>" if block.is_rework
    badges << "<small class=\"load-badge text-info\">Early</small>" if block.is_early
    badges << "<small class=\"load-badge text-primary\">Strip</small>" if block.is_strip
    return badges.join(" ").html_safe
  end

  def filter_text_field(form, field, label)
    "<div class=\"form-group\">#{form.label(field, "#{label}:")}#{form.text_field(field, class: ["form-control", "form-control-sm"], onchange: 'this.form.submit();', value: params[field])}</div>"
  end

  def filter_number_field(form, field, label)
    "<div class=\"form-group\">#{form.label(field, "#{label}:")}#{form.number_field(field, class: ["form-control", "form-control-sm"], onchange: 'this.form.submit();', value: params[field])}</div>"
  end

  def filter_date_field(form, field, label)
    "<div class=\"form-group\">#{form.label(field, "#{label}:")}#{form.date_field(field, class: ["form-control", "form-control-sm"], onchange: 'this.form.submit();', value: params[field])}</div>"
  end

  def filter_dropdown(form, field, label, values, options = {})
    values.uniq! unless options[:no_uniq]
    values.reject!(&:blank?) unless options[:allow_blank]
    values.sort! unless options[:no_sort]
    should_include_blank = options.fetch :include_blank, true
    select = form.select(field, options_for_select(values, params[field]), { include_blank: should_include_blank }, { class: ['custom-select', 'custom-select-sm'], onchange: 'this.form.submit();' })
    "<div class=\"form-group\">#{form.label(field, "#{label}:")}#{select}</div>"
  end

end