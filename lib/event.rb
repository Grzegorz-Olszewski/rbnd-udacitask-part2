class EventItem
  include Listable
  attr_reader :type,:description, :start_date, :end_date

  def initialize(type,description, options={})
    @type = type
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end
  #def format_date
  #  dates = @start_date.strftime("%D") if @start_date
  #  dates << " -- " + @end_date.strftime("%D") if @end_date
  #  dates = "N/A" if !dates
  #  return dates
  #end
  def details
    format_description(@type,@description) + "event dates: " + format_date(start_date: @start_date,end_date: @end_date)
  end
end
