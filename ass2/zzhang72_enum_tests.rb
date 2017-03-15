load 'zzhang72_enum.rb'

class Array
	include P2Enumerable
end

class Hash
	include P2Enumerable
end

def test_P2each
	s = 0
	[1, 2, 3].p2each{ | e | s += e }
	raise "#{__method__} error" if s != 6
	p "#{__method__} passed"
end
test_P2each


def test_p2all1?
	r = [1,2,3].p2all?{ | e | e < 4}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2all1?

def test_p2all2?
	r = [1,2,3].p2all?{ | e | e > 2}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2all2?


def test_p2any1?
	r = [1,2,3].p2any?{ | e | e < 2}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2any1?

def test_p2any2?
	r = [1,2,3].p2any?{ | e | e < 1}
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2any2?


def test_p2collect1
	r = [1, 2, 3].p2collect{ | e | e + 1}
	raise "#{__method__} error" if r != [2, 3, 4]
	p "#{__method__} passed"
end
test_p2collect1

def test_p2collect2
	r = [1, 2, 3].p2collect{ | e | e * 2}
	raise "#{__method__} error" if r != [2, 4, 6]
	p "#{__method__} passed"
end
test_p2collect2


def test_P2collect_concat1
	r = [1, 2].P2collect_concat{ | e | e + 3}
	raise "#{__method__} error" if r != [4, 5]
	p "#{__method__} passed"
end
test_P2collect_concat1

def test_P2collect_concat2
	r = [[1, 2], [3, 4]].P2collect_concat{ | e | e + [5]}
	raise "#{__method__} error" if r != [1, 2, 5, 3, 4, 5]
	p "#{__method__} passed"
end
test_P2collect_concat2


def test_p2count1
	r = [1, 2, 3].p2count { | e | e > 0}
	raise "#{__method__} error" if r != 3
	p "#{__method__} passed"
end
test_p2count1

def test_p2count2
	r = [1, 2, 3].p2count { | e | e % 2 != 0}
	raise "#{__method__} error" if r != 2
	p "#{__method__} passed"
end
test_p2count2


# def test_p2cycle1
# 	[1, 2, 3].p2cycle(2) { | e | puts e}
# end
# test_p2cycle1

# def test_p2cycle2
# 	[1, 2, 3].p2cycle { | e | puts e}
# end
# test_p2cycle2


def test_p2detect1
	r = [1, 2, 3].p2detect(lambda{4}) { | e | e % 4 == 0}
	raise "#{__method__} error" if r != 4
	p "#{__method__} passed"
end
test_p2detect1

def test_p2detect2
	r = [1, 2, 3].p2detect { | e | e % 4 == 0}
	raise "#{__method__} error" if r != nil
	p "#{__method__} passed"
end
test_p2detect2


def test_p2drop1
	r = [1, 2, 3, 4].p2drop(2)
	raise "#{__method__} error" if r != [3, 4]
	p "#{__method__} passed"
end
test_p2drop1

def test_p2drop2
	r = [1, 2, 3, 4].p2drop(10)
	raise "#{__method__} error" if r != []
	p "#{__method__} passed"
end
test_p2drop2


def test_p2drop_while1
	r = [1, 2, 3, 4, 5, 0].p2drop_while { | e | e != 3}
	raise "#{__method__} error" if r != [4, 5, 0]
	p "#{__method__} passed"
end
test_p2drop_while1

def test_p2drop_while2
	r = [1, 2, 3, 4, 5, 0].p2drop_while { | e | e > 0}
	raise "#{__method__} error" if r != []
	p "#{__method__} passed"
end
test_p2drop_while2


# def test_p2each_cons1
# 	[1,2,3,4,5].p2each_cons(3) {|a| p a}
# end
# test_p2each_cons1

# def test_p2each_cons2
# 	[1,2,3,4,5].p2each_cons(2) {|a| p a}
# end
# test_p2each_cons2

# def test_p2each_slice1
# 	[1,2,3,4,5,6,7,8,9,10].p2each_slice(4) {|a| p a}
# end
# test_p2each_slice1

# def test_p2each_slice2
# 	[1,2,3,4,5,6,7,8,9,10].p2each_slice(3) {|a| p a}
# end
# test_p2each_slice2


def test_p2each_with_index1
	hash = Hash.new
	%w(cat dog wombat).p2each_with_index { |item, index|
  	hash[item] = index}
  	raise "#{__method__} error" if hash != {"cat"=>0, "dog"=>1, "wombat"=>2}
  	p "#{__method__} passed"
end
test_p2each_with_index1

def test_p2each_with_index2
	hash = Hash.new
	%w(cat dog wombat).p2each_with_index { |item, index|
  	hash[item] = index + 1}
  	raise "#{__method__} error" if hash != {"cat"=>1, "dog"=>2, "wombat"=>3}
  	p "#{__method__} passed"
end
test_p2each_with_index2


def test_p2entries1
	r = { 'a'=>1, 'b'=>2, 'c'=>3 }.p2entries
	raise "#{__method__} error" if r != [["a", 1], ["b", 2], ["c", 3]]
	p "#{__method__} passed"
end
test_p2entries1

def test_p2entries2
	r = [1, 2, 3].p2entries
	raise "#{__method__} error" if r != [1, 2, 3]
	p "#{__method__} passed"
end
test_p2entries2


def test_p2find1
	r = [1, 2, 3].p2find(lambda{4}) { | e | e % 4 == 0}
	raise "#{__method__} error" if r != 4
	p "#{__method__} passed"
end
test_p2find1

def test_p2find2
	r = [1, 2, 3].p2find { | e | e % 4 == 0}
	raise "#{__method__} error" if r != nil
	p "#{__method__} passed"
end
test_p2find2


def test_p2find_all1
	r = [1, 2, 3, 4, 5, 6].p2find_all {| e | e < 3}
	raise "#{__method__} error" if r != [1, 2]
	p "#{__method__} passed"
end
test_p2find_all1

def test_p2find_all2
	r = [1, 2, 3, 4, 5, 6].p2find_all {| e | e % 2 == 0}
	raise "#{__method__} error" if r != [2, 4, 6]
	p "#{__method__} passed"
end
test_p2find_all2


def test_p2find_index1
	r = [1,2,3].p2find_index{ | i | i > 2}
	raise "#{__method__} error" if r != 2
	p "#{__method__} passed"
end
test_p2find_index1

def test_p2find_index2
	r = [1,2,3,4,5,6,7,8,9,10].p2find_index{ | i | i % 8 == 0}
	raise "#{__method__} error" if r != 7
	p "#{__method__} passed"
end
test_p2find_index2


def test_p2first1
	r = [1,2,3,4].p2first(2)
	raise "#{__method__} error" if r != [1, 2]
	p "#{__method__} passed"
end
test_p2first1

def test_p2first2
	r = [1,2,3,4].p2first(10)
	raise "#{__method__} error" if r != [1, 2, 3, 4]
	p "#{__method__} passed"
end
test_p2first2


def test_group_by1
	a = [1,2,3,4,5,6]
	r = a.p2group_by { |i| i%3 }
	raise "#{__method__} error" if r != {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
	p "#{__method__} passed"
end
test_group_by1

def test_group_by2
	a = [1,2,3,4,5,6]
	r = a.p2group_by { |i| i < 3 }
	raise "#{__method__} error" if r != {true=>[1, 2], false=>[3,4,5,6]}
	p "#{__method__} passed"
end
test_group_by2


def test_p2inject1
	r = [1,2,3].p2inject(0) { |s, e| s + e}
	raise "#{__method__} error" if r != 6
	p "#{__method__} passed"
end
test_p2inject1

def test_p2inject2
	r = [5,6,7,8,9,10].p2inject(1) { |s, e| s * e}
	raise "#{__method__} error" if r != 151200
	p "#{__method__} passed"
end
test_p2inject2


def test_p20inject1
	r = [1,2,3].p2para0inject {|s, e| s + e}
	raise "#{__method__} error" if r != 6
	p "#{__method__} passed"
end
test_p20inject1

def test_p20inject2
	r = [5,6,7,8,9,10].p2para0inject {|s, e| s * e}
	raise "#{__method__} error" if r != 151200
	p "#{__method__} passed"
end
test_p20inject2


def test_p2minmax1
	a = %w(albatross dog horse)
	r = a.p2minmax { |a, b| a.length <=> b.length }
	raise "#{__method__} error" if r != ["dog", "albatross"]
	p "#{__method__} passed"
end
test_p2minmax1

def test_p2minmax2
	a = [1, 2, 3, 4, 5]
	r = a.p2minmax { |a, b| a<=> b }
	raise "#{__method__} error" if r != [1, 5]
	p "#{__method__} passed"
end
test_p2minmax2


def test_p2minmax_by1
	a = %w(albatross dog horse)
	r = a.p2minmax_by { |x| x.length }
	raise "#{__method__} error" if r != ["dog", "albatross"]
	p "#{__method__} passed"
end
test_p2minmax_by1

def test_p2minmax_by2
	a = [1, 2, 3, 4, 5]
	r = a.p2minmax_by { |x| x }
	raise "#{__method__} error" if r != [1, 5]
	p "#{__method__} passed"
end
test_p2minmax_by2


def test_p2partition1
	a = [1, 2, 3, 4, 5, 6]
	r = a.p2partition { |v| v.even? }
	raise "#{__method__} error" if r != [[2, 4, 6], [1, 3, 5]]
	p "#{__method__} passed"
end
test_p2partition1

def test_p2partition2
	a = [1, 2, 3, 4, 5, 6]
	r = a.p2partition { |v| v.odd? }
	raise "#{__method__} error" if r != [[1, 3, 5], [2, 4, 6]]
	p "#{__method__} passed"
end
test_p2partition2


def test_p2reject1
	r = [1, 2, 3, 4, 5].p2reject { |num| num.even? }
	raise "#{__method__} error" if r != [1, 3, 5]
	p "#{__method__} passed"
end
test_p2reject1

def test_p2reject2
	r = [1, 2, 3, 4, 5].p2reject { |num| num.odd? }
	raise "#{__method__} error" if r != [2, 4]
	p "#{__method__} passed"
end
test_p2reject2


def test_p2take1
	a = [1, 2, 3, 4, 5, 0]
	r = a.p2take(3)
	raise "#{__method__} error" if r != [1, 2, 3]
	p "#{__method__} passed"
end
test_p2take1

def test_p2take2
	a = [1, 2, 3, 4, 5, 0]
	r = a.p2take(10)
	raise "#{__method__} error" if r != [1, 2, 3, 4, 5, 0]
	p "#{__method__} passed"
end
test_p2take2


def test_p2take_while1
	a = [1, 2, 3, 4, 5, 0]
	r = a.p2take_while { |i| i < 3 }
	raise "#{__method__} error" if r != [1, 2]
	p "#{__method__} passed"
end
test_p2take_while1

def test_p2take_while2
	a = [1, 2, 3, 4, 5, 0]
	r = a.p2take_while { |i| i > 3 }
	raise "#{__method__} error" if r != []
	p "#{__method__} passed"
end
test_p2take_while2


def test_p2to_a1
	r = { 'a'=>1, 'b'=>2, 'c'=>3 }.p2to_a
	raise "#{__method__} error" if r != [["a", 1], ["b", 2], ["c", 3]]
	p "#{__method__} passed"
end
test_p2to_a1

def test_p2to_a2
	r = [1, 2, 3].p2entries
	raise "#{__method__} error" if r != [1, 2, 3]
	p "#{__method__} passed"
end
test_p2to_a2


def test_p2to_h1
	a = [1, 2, 3, 4]
	r = a.p2collect{|a|[a,(a * 2)]}.p2to_h
	raise "#{__method__} error" if r != {1=>2, 2=>4, 3=>6, 4=>8}
	p "#{__method__} passed"
end
test_p2to_h1

def test_p2to_h2
	a = {"a"=>1, "b"=>2}
	r = a.p2to_h
	raise "#{__method__} error" if r != {"a"=>1, "b"=>2}
	p "#{__method__} passed"
end
test_p2to_h2


def test_p2min1
	a = %w(albatross dog horse)
	r = a.p2min { |a, b| a.length <=> b.length }
	raise "#{__method__} error" if r != "dog"
	p "#{__method__} passed"
end
test_p2min1

def test_p2min2
	a = [1, 2, 3, 4, 5]	
	r = a.p2min { |a, b| a <=> b }
	raise "#{__method__} error" if r != 1
	p "#{__method__} passed"
end
test_p2min2


def test_p2max1
	a = %w(albatross dog horse)
	r = a.p2max { |a, b| a.length <=> b.length }
	raise "#{__method__} error" if r != "albatross"
	p "#{__method__} passed"
end
test_p2max1

def test_p2max2
	a = [1, 2, 3, 4, 5]	
	r = a.p2max { |a, b| a <=> b }
	raise "#{__method__} error" if r != 5
	p "#{__method__} passed"
end
test_p2max2


def test_p2none1?
	a = %w{ant bear cat}
	r = a.p2none? { |word| word.length == 5 }
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2none1?

def test_p2none2?
	a = %w{ant bear cat}
	r = a.p2none? { |word| word.length < 5 }
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2none2?


def test_p2one1?
	a = %w{ant bear cat}
	r = a.p2one? { |word| word.length == 4 }
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end
test_p2one1?

def test_p2one2?
	a = %w{ant bear cat}
	r = a.p2one? { |word| word.length == 5 }
	raise "#{__method__} error" if r != false
	p "#{__method__} passed"
end
test_p2one2?


def test_p2sort1
	a = %w(rheaa kea flea)
	r = a.p2sort {|a, b| a.length <=> b.length}
	raise "#{__method__} error" if r != ["kea", "flea", "rheaa"]
	p "#{__method__} passed"
end
test_p2sort1

def test_p2sort2
	a = [5, 4, 3, 2, 1]
	r = a.p2sort {|a, b| a <=> b}
	raise "#{__method__} error" if r != [1, 2, 3, 4, 5]
	p "#{__method__} passed"
end
test_p2sort2