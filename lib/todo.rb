class TodoItem
  include Listable
  attr_reader :type, :description, :due, :priority

  def initialize(type,description, options={})
    @type = type
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority] 
  end
  def details
    format_description(@type,@description) + "due: " +
    format_date(start_date: @due) +
    format_priority(@priority)
  end
end
