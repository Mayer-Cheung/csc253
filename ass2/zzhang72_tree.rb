load 'zzhang72_enum.rb'
class TreeNode
	attr_accessor :data, :left, :right
	def initialize data, left, right
		@data = data
		@left = left
		@right = right
	end
end
class P2Tree
	include P2Enumerable
	attr_accessor :root, :size
	def initialize()
		@root = nil
		@size = 0
	end
	def insert(val)
		if @root == nil
			@root = TreeNode.new(val, nil, nil)
		else
			find_and_insert(val, @root)
		end
		@size += 1
	end
	def find_and_insert(d, current)
		if d < current.data
			if current.left == nil
				current.left = TreeNode.new(d, nil, nil)
			else
				find_and_insert(d, current.left)
			end
		else
			if current.right == nil
				current.right = TreeNode.new(d, nil, nil)
			else
				find_and_insert(d, current.right)
			end
		end
	end
	def p2each(&blk)
		inOrder(self.root, &blk)
	end
	def inOrder(current, &blk)
	  if current == nil
	    return
	  end
		inOrder(current.left, &blk) if current.left != nil
		yield current.data
		inOrder(current.right, &blk) if current.right != nil
	end
	def preOrder(current, &blk)
	  if current == nil
	    return
	  end
	  	yield current.data
		preOrder(current.left, &blk) if current.left != nil
		preOrder(current.right, &blk) if current.right != nil
	end
	def postOrder(current, &blk)
	  if current == nil
	    return
	  end
		postOrder(current.left, &blk) if current.left != nil
		postOrder(current.right, &blk) if current.right != nil
		yield current.data
	end
	def p2each_with_level(&blk)
		inOrder_with_level(self.root, 1, &blk)
	end
	def inOrder_with_level(current, depth, &blk)
	  if current == nil
	    return
	  end
		inOrder_with_level(current.left, depth + 1, &blk)
		yield current.data, depth
		inOrder_with_level(current.right, depth + 1, &blk)
	end
end
