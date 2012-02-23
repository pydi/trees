require 'rspec'
require './binarysearch_tree'

include BinarySearchTree

describe Node do 
  shared_examples 'Node with word "foo"' do 
    its(:word) { should == 'foo'}
  end
  
  shared_examples 'Node with one leaf child' do
    its(:size) { should == 2}
  end

  shared_examples 'Node with two leaf children' do 
    its(:size) { should == 3}
  end

  shared_examples 'Node with no children' do 
    its(:left) { should be_nil}
    its(:right){ should be_nil}
  end

  context 'with word "foo" and no children' do
    subject{ Node.new('foo') }

    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with no children'
   
    its(:size) { should == 1}
    its(:count) { should == 1}
    its(:words) { should == ['foo']}
    its(:count_all) { should == 1}
  end

  context 'with word "foo" having leaf child node "bar"' do
    before do
      @node = Node.new 'foo'
      @node.insert(Node.new('bar'))
    end
    
    subject{ @node }
    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with one leaf child'
    
    its(:size) { should == 2}
    its(:count) { should == 1}
    its(:words) { should == ['bar', 'foo']}
    its(:count_all) { should == 2}

    describe 'its child on the right' do 
      subject { @node.left}
     
      it_should_behave_like 'Node with no children'
    
      its(:size) { should == 1}
      its(:count) { should == 1}
      its(:word)  { should == 'bar'}
      its(:words) { should == ['bar']}
      its(:count_all) { should == 1}
    end
  end 

  context 'with word "foo" having leaf child "hoge"' do 
    
    before do
      @node = Node.new 'foo'
      @node.insert(Node.new('hoge'))
    end
    
    subject{ @node }
    it_should_behave_like 'Node with word "foo"'
    it_should_behave_like 'Node with one leaf child'
    
    its(:size) { should == 2}
    its(:count) { should == 1}
    its(:words) { should == ['foo', 'hoge']}
    its(:count_all) { should == 2}

    describe 'its child on the right' do 
      subject { @node.right}
     
      it_should_behave_like 'Node with no children'
    
      its(:size) { should == 1}
      its(:count) { should == 1}
      its(:word)  { should == 'hoge'}
      its(:words) { should == ['hoge']}
      its(:count_all) { should == 1}
    end
  end
  
  context 'with word "foo" and node with word "hoge" inserted 3 times' do
    before do 
      @node = Node.new 'foo'
      3.times{ @node.insert(Node.new('hoge'))}
    end

    subject { @node }
    it_should_behave_like 'Node with word "foo"'
    
    its(:size) { should == 2}
    its(:count) { should == 1}
    its(:words) { should == ['foo', 'hoge']}
    its(:count_all) { should == 4} 
     
    describe 'its child on the right' do 
      subject { @node.right}
     
      it_should_behave_like 'Node with no children'
    
      its(:size) { should == 1}
      its(:count) { should == 3}
      its(:word)  { should == 'hoge'}
      its(:words) { should == ['hoge']}
      its(:count_all) { should == 3}
    end
  end
  

  context 'with word "a" and inserted with words "b" ~ "j"' do 
    before do 
      @node = Node.new('a')
      %w{b c d e f g h i j}.each do |word|
         @node.insert(Node.new(word))
       end
    end
    
    subject{ @node }
   
    its(:size) {should == 10}
    its(:words) {should = %w{a b c d e f g h i}}
  end 
end
 
