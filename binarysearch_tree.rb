#### reference :git://gist.github.com/812489.git

module BinarySearchTree
  class Node
    attr_reader :word, :count, :left, :right
    include Enumerable
    
    def initialize(word)
      @word,@count = word, 1
    end

    def each
      @left.each{|node| yield node } unless @left.nil?
      yield self
      @right.each{|node| yield node } unless @right.nil?
    end
    
    def size
      size = 1
      size += @left.size unless left.nil?
      size += @right.size unless right.nil?
      size
    end
   
    def insert(new_node)
      case @word <=> new_node.word
        when 1
           insert_into(:left, new_node) 
        when 0
           @count += 1
        when -1
           insert_into(:right, new_node) 
        end 
    end
   
    def insert_into(destination, new_node)
      var = destination.to_s
      eval(%Q{
        if @#{var}.nil?
          @#{var} = new_node
        else
          @#{var}.insert(new_node)   
        end
      })
    end

    def words
      entries.map{|e| e.word}
    end

   def count_all
     self.map{|node| node.count}.reduce(:+)
   end
   
    protected :insert_into
  end
end
