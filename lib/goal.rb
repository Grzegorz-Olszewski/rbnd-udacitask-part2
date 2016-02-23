class GoalItem	
	include Listable
	attr_reader :type, :description, :due, :importancy_level
	def initialize(type,description, options={})
		@type = type
		@description = description
		@due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
		@priority = options[:importancy_level] 
	end
	def details
		format_description(@type,@description) + "due: " +
		format_date(start_date: @due) +
		"#{importancy_level}"
	end
end