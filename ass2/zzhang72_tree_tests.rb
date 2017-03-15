load 'zzhang72_tree.rb'
root = P2Tree.new(2)
root.left = P2Tree.new(1)
root.right = P2Tree.new(3)
root.left.left = P2Tree.new(4)
root.p2each {| x | puts x.data}
root.p2each_with_level {| x | puts x.data}
