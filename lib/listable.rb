module Listable
	def format_description(type,description)
		"Type:#{type}".ljust(12) +"#{description}".ljust(25)
	end
	def format_date(options={})
		due = options[:due]
		start_date = options[:start_date]
    	end_date = options[:end_date]
    	if due == true
    		dates = due
    	else
    		dates = start_date.strftime("%D") if start_date
    		dates << " -- " + end_date.strftime("%D") if end_date
    		dates = "N/A" if !dates
    	end
    	return dates
	end
	def format_priority(priority)
	value = ""	
    value = " ⇧".colorize(:blue) if priority == "high"
    value = " ⇨".colorize(:green) if priority == "medium"
    value = " ⇩".colorize(:red) if priority == "low"
    value = "" if !priority
    return value
  end
end
