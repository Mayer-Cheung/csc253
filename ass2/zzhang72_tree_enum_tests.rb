load 'zzhang72_tree.rb'
def my_tree
	root = P2Tree.new(50)
	root.left = P2Tree.new(21)
	root.right = P2Tree.new(100)
	root.left.left = P2Tree.new(4)
	root.left.right = P2Tree.new(33)
	root.right.left = P2Tree.new(78)
	root.right.right = P2Tree.new(3)
	return root
end

def test_p2all1?
	r = my_tree.p2all? {| a | a.data > 1}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2all1?

def test_p2all2?
	r = my_tree.p2all? {| a | a.data < 100}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2all2?



def test_p2any1?
	r = my_tree.p2any? {| a | a.data < 1}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2any1?


def test_p2any1?
	r = my_tree.p2any? {| a | a.data < 1}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2any1?

def test_p2any2?
	r = my_tree.p2any? {| a | a.data > 50}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2any2?


def test_p2collect
	r = my_tree.p2collect {| a | a.data + 1}
	raise "#{__method__} error" if r != [5, 22, 34, 51, 79, 101, 4]
	p "#{__method__} passed"
end
test_p2collect


def test_p2count
	r = my_tree.p2count { | e | e.data > 30}
	raise "#{__method__} error" if r != 4
	p "#{__method__} passed"
end
test_p2count


def test_p2cycle
	r = my_tree.p2cycle(2) { | e | puts e.data}
	p r
end
# test_p2cycle


def test_p2detect1
	r = my_tree.p2detect { | e | e.data == 33}
	raise "#{__method__} error" if r == nil
	p "#{__method__} passed"
end
test_p2detect1

def test_p2detect2
	r = my_tree.p2detect { | e | e.data == 343}
	raise "#{__method__} error" if r != nil
	p "#{__method__} passed"
end
test_p2detect2


def test_p2drop1
	r = my_tree.p2drop(6)
	raise "#{__method__} error" if r.size != 1
	p "#{__method__} passed"
end
test_p2drop1

def test_p2drop2
	r = my_tree.p2drop(10)
	raise "#{__method__} error" if r.size != 0
	p "#{__method__} passed"
end
test_p2drop2


def test_p2drop_while1
	r = my_tree.p2drop_while {|e| e.data > 10}
	raise "#{__method__} error" if r.size != 6
	p "#{__method__} passed"
end
test_p2drop_while1

def test_p2drop_while2
	r = my_tree.p2drop_while {|e| e.data > 0}
	raise "#{__method__} error" if r.size != 0
	p "#{__method__} passed"
end
test_p2drop_while2


def test_p2sort1
	r = my_tree.p2sort {|a, b| a.data <=> b.data}
	res = []
	r.p2each {|e| res << e.data}
	raise "#{__method__} error" if res != [3, 4, 21, 33, 50, 78, 100]
	p "#{__method__} passed"
end
test_p2sort1

def test_p2sort2
	r = my_tree.p2sort {|a, b| b.data <=> a.data}
	res = []
	r.p2each {|e| res << e.data}
	raise "#{__method__} error" if res != [100, 78, 50, 33, 21, 4, 3]
	p "#{__method__} passed"
end
test_p2sort2


def test_p2one1?
	r = my_tree.p2one? {|a| a.data > 5}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2one1?

def test_p2one2?
	r = my_tree.p2one? {|a| a.data > 100}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2one2?


def test_p2none1?
	r = my_tree.p2none? {|a| a.data > 1}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2none1?

def test_p2none2?
	r = my_tree.p2none? {|a| a.data > 100}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2none2?


def test_p2max
	r = my_tree.p2max {|a, b| a.data <=> b.data}
	raise "#{__method__} error" if r.data != 100
	p "#{__method__} passed"
end
test_p2max


def test_p2min
	r = my_tree.p2min {|a, b| a.data <=> b.data}
	raise "#{__method__} error" if r.data != 3
	p "#{__method__} passed"
end
test_p2min


def test_p2collect
	r = my_tree.p2collect{|a|[a.data,(a.data * 2)]}.p2to_h
	raise "#{__method__} error" if r != {4=>8, 21=>42, 33=>66, 50=>100, 78=>156, 100=>200, 3=>6}
	p "#{__method__} passed"
end
test_p2collect


def test_p2entries
	r = my_tree.p2entries
	res = []
	r.p2each {|x| res << x.data}
	raise "#{__method__} error" if res != [4, 21, 33, 50, 78, 100, 3]
	p "#{__method__} passed"
end
test_p2entries


def test_p2take_while
	r = my_tree.p2take_while { |i| i.data > 30 }
	res = []
	r.p2each {|x| res << x.data}
	raise "#{__method__} error" if res != []
	p "#{__method__} passed"
end
test_p2take_while


def test_p2take
	r = my_tree.p2take(3)
	res = []
	r.p2each {|x| res << x.data}
	raise "#{__method__} error" if res != [4, 21, 33]
	p "#{__method__} passed"
end
test_p2take


def test_p2reject
	r = my_tree.p2reject { |num| num.data.odd? }
	res = []
	r.p2each {|x| res << x.data}
	raise "#{__method__} error" if res != [4, 50, 78, 100]
	p "#{__method__} passed"
end
test_p2reject


def test_p2partition
	r = my_tree.p2partition { |v| v.data.odd? }
	res = []
	r[0].p2each{|x| res << x.data}
	raise "#{__method__} error" if res != [21, 33, 3]
	p "#{__method__} passed"
end
test_p2partition


def test_p2minmax_by
	r = my_tree.p2minmax_by { |x| x.data }
	raise "#{__method__} error" if r[0].data != 3 or r[1].data != 100
	p "#{__method__} passed"
end
test_p2minmax_by


def test_p2inject
	r = my_tree.p2inject(0) {|a, b| a += b.data}
	raise "#{__method__} error" if r != 289
	p "#{__method__} passed"
end
test_p2inject


def test_p2group_by
	r = my_tree.p2group_by { |i| i.data % 3 }
	res = []
	r.values[0].p2each {|e| res << e.data}
	raise "#{__method__} error" if res != [4, 100]
	p "#{__method__} passed"
end
test_p2group_by


def test_p2first
	r = my_tree.p2first(2)
	res = []
	r.p2each {|x| res << x.data}
	raise "#{__method__} error" if res != [4, 21]
	p "#{__method__} passed"
end
test_p2first


def test_p2find_index
	r = my_tree.p2find_index{ | i | i.data % 2 == 1}
	raise "#{__method__} error" if r != 1
	p "#{__method__} passed"
end
test_p2find_index


def test_p2find_all
	res = []
	r = my_tree.p2find_all {| e | e.data % 2 == 0}
	r.p2each {|e| res << e.data}
	raise "#{__method__} error" if res != [4, 50, 78, 100]
	p "#{__method__} passed"
end
test_p2find_all


def test_p2find1
	r = my_tree.p2find { | e | e.data % 4 == 0}
	raise "#{__method__} error" if r.data != 4
	p "#{__method__} passed"
end
test_p2find1


def test_p2find2
	r = my_tree.p2find { | e | e.data > 100}
	raise "#{__method__} error" if r != nil
	p "#{__method__} passed"
end
test_p2find2
