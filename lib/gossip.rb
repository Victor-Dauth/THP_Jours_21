#require 'bundler'
#Bundler.require

class Gossip

  attr_accessor :author, :content, :comments

  def initialize(array_info)
    
    @comments = []
    array_info.each_with_index do |info, i|
      if i == 0
        @author = array_info[i]
      elsif i == 1
        @content = array_info[i]
      else 
        @comments << array_info[i]
      end
    end
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      
      array = [@author, @content]
      @comments.each {|com| array << com}
      
      csv << array
    end
  end

  def self.all

    all_gossips = []

    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line)
    end

    return all_gossips
  end

  def self.find(num)

    self.all[num.to_i - 1]
  end

  def self.update(new_author, new_content, id)

    all_gossips = []

    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << csv_line
    end

    all_gossips[id.to_i - 1][0] = new_author
    all_gossips[id.to_i - 1][1] = new_content

    CSV.open("./db/gossip.csv", 'w') do |csv_gossip|
      all_gossips.each do |line|
        csv_gossip << line
      end
    end
  end

  def self.new_com(com, id)

    all_gossips = []

    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << csv_line
    end

    all_gossips[id.to_i - 1] << com 

    CSV.open("./db/gossip.csv", 'w') do |csv_gossip|
      all_gossips.each do |line|
        csv_gossip << line
      end
    end
  end
end

#binding.pry
