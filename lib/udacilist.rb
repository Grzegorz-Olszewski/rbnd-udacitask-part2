class UdaciList
  include UdaciListErrors

  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title]
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    if type != "todo" && type != "event" && type != "link" && type != "goal"
      raise UdaciListErrors::InvalidItemType
    end
    if   options[:priority] != nil &&options[:priority] != "high" && options[:priority] != "medium" \
      && options[:priority] != "low" 
      raise UdaciListErrors::InvalidPriorityValue
    end
    @items.push TodoItem.new(type,description, options) if type == "todo"
    @items.push EventItem.new(type,description, options) if type == "event"
    @items.push LinkItem.new(type,description, options) if type == "link"
    @items.push GoalItem.new(type,description, options) if type == "goal"
  end
  def delete(index, *other_indexes)
    if (@items.length - (1 + other_indexes.length)) < index
      raise UdaciListErrors::IndexExceedsListSize
    end
    @items.delete_at(index)
    other_indexes.each do |to_delete|
      @items.delete_at(to_delete)
    end
  end

  def all
    if @title == nil
     @title = "Untitled List"
   end
   table = Terminal::Table.new do |t|
    t.title = @title
    @items.each_with_index do |item, position|
      t.add_row [position + 1,item.details]
    end
  end
  table.style = {:border_x => "=", :border_i => "x"}
  puts table
end
  

  def filter(item_type)
    filtered_items = self.class.new(title:"List of #{item_type}'s from #{@title}")
    @items.each do |item|
      if item.type == item_type
        filtered_items.items.push item
      end
    end
    if filtered_items == nil
      raise UdaciListErrors::NoItemsOfThatType
    end
    return filtered_items
  end
end
