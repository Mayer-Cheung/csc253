def test_P2each
	s = 0
	[1, 2, 3].p2each{ | e | s += e }
	raise "#{__method__} error" if s != 6
	p "#{__method__} passed"
end

class Array
	def p2each
		self.size.times do | i |
			yield( self[ i ])
		end
	end
end

class Hash
	def p2each( &blk )
		self.size.times do | i |
			res = Hash.new
			res[self.keys[i]] = self.values[i]
			blk.call(res)
		end
	end
end


test_P2each

def test_p2all?
	r = [1,2,3].p2all?{ | e | e < 4}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end

module P2Enumerable
	def p2all?
		p2each do | e |
			res = yield( e )
			if res == false
				return false
			end
		end
		return true
	end
end

class Array
	include P2Enumerable
end

class Hash
	include P2Enumerable
end

test_p2all?

def test_p2any?
	r = [1,2,3].p2any?{ | e | e < 2}
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end

module P2Enumerable
	def p2any?
		p2each do | e |
			res = yield( e )
			if res == true
				return true
			end
		end
		return false
	end
end

test_p2any?

def test_p2collect
	r = [1, 2, 3].p2collect{ | e | e + 1}
	raise "#{__method__} error" if r != [2, 3, 4]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2collect
		r = Array.new
		p2each do | e |
			res = yield( e )
			r << res
		end
		return r
	end
end

test_p2collect

def test_P2collect_concat
	r = [1, 2].P2collect_concat{ | e | e + 3}
	raise "#{__method__} error" if r != [4, 5]
	p "#{__method__} passed"
end

module P2Enumerable
	def P2collect_concat
		r = []
		p2each do | e |
			res = yield(e)
			if res.kind_of? Array
				r.concat res
			else
				r << res
			end
		end
		return r
	end
end

test_P2collect_concat

def test_p2count
	r = [1, 2, 3].p2count { | e | e > 0}
	raise "#{__method__} error" if r != 3
	p "#{__method__} passed"
end

module P2Enumerable
	def p2count
		r = 0
		p2each do | e |
			res = yield ( e )
			if res != false
				r += 1
			end
		end
		return r
	end
end

test_p2count

# def test_p2cycle
# 	[1, 2, 3].p2cycle(2) { | e | puts e}

module P2Enumerable
	def p2cycle( s = nil, &blk )
		if s == nil
			p2infcycle( 1, &blk )
		end
		p2each do | e |
			return if s <= 0
			blk.call( e )
		end
		p2cycle( s - 1, &blk )
	end
end

module P2Enumerable
	def p2infcycle( s = 1, &blk )
		p2each do | e |
			blk.call ( e )
		end
		p2infcycle( s + 1, &blk )
	end
end

# a = [1, 2]
# a.p2cycle(2) { | x | puts x}

def test_p2detect
	r = [1, 2, 3].p2detect(lambda{4}) { | e | e % 4 == 0}
	raise "#{__method__} error" if r != 4
	p "#{__method__} passed"
end

module P2Enumerable
	def p2detect( ifnone = nil, &blk )
		p2each do | e |
			if blk.call( e ) == true
				return e
			end
		end
		if ifnone != nil
			return ifnone.call
		else
			return nil
		end
	end
end

test_p2detect


def test_p2drop
	r = [1, 2, 3, 4].p2drop(2)
	raise "#{__method__} error" if r != [3, 4]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2drop( n )
		res = Array.new
		cnt = 0
		p2each do | e |
			if cnt < n
				cnt += 1
			else
				res << e
			end
		end
		return res
	end
end

test_p2drop


def test_p2drop_while
	r = [1, 2, 3, 4, 5, 0].p2drop_while { | e | e != 3}
	raise "#{__method__} error" if r != [4, 5, 0]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2drop_while
		res = []
		flag = false
		p2each do | e |
			if flag
				res << e
			end
			if (not yield ( e ))
				flag = true
			end
		end
		return res
	end
end

test_p2drop_while


module P2Enumerable
	def p2each_cons ( n , &blk )
		tmp = self.size
		cnt = 0
		res = []
		p2each do | e |
			if cnt < n
				res << e
				cnt += 1
			else
				blk.call(res)
				res = res.p2drop(1)
				res << e
			end
		end
		blk.call(res)
	end
end

# [1,2,3,4,5].p2each_cons(3) {|a| p a}

module P2Enumerable
	def p2each_slice ( n , &blk )
		tmp = self.size
		cnt = 0
		res = []
		p2each do | e |
			if cnt < n
				res << e
				cnt += 1
			else
				blk.call(res)
				cnt = 1
				res = res.p2drop(n)
				res << e
			end
		end
		if cnt != 0
			blk.call(res)
		end
	end
end

# [1,2,3,4,5,6,7,8,9,10].p2each_slice(4) {|a| p a}

def test_p2each_with_index
	hash = Hash.new
	%w(cat dog wombat).p2each_with_index { |item, index|
  	hash[item] = index}
  	raise "#{__method__} error" if hash != {"cat"=>0, "dog"=>1, "wombat"=>2}
  	p "#{__method__} passed"
end

module P2Enumerable
	def p2each_with_index
		index = 0
		p2each do | e |
			yield e, index
			index += 1
		end
		self
	end
end

test_p2each_with_index

def test_p2entries
	r = { 'a'=>1, 'b'=>2, 'c'=>3 }.p2entries
	raise "#{__method__} error" if r != [["a", 1], ["b", 2], ["c", 3]]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2entries
		res = []
		p2each do | e |
			if e.is_a? Hash
				r = [e.keys[0], e.values[0]]
				res << r
			else
				res << e
			end
		end
		return res
	end
end

test_p2entries

def test_p2find
	r = [1, 2, 3].p2find(lambda{4}) { | e | e % 4 == 0}
	raise "#{__method__} error" if r != 4
	p "#{__method__} passed"
end

module P2Enumerable
	alias p2find p2detect
end

test_p2find


def test_p2find_all
	r = [1, 2, 3, 4, 5, 6].p2find_all {| e | e < 3}
	raise "#{__method__} error" if r != [1, 2]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2find_all
		res = []
		p2each do | e |
			if (yield (e)) == true
				res << e
			end
		end
		return res
	end
end

test_p2find_all


def test_p2find_index
	r = [1,2,3].p2find_index{ | i | i > 2}
	raise "#{__method__} error" if r != 2
	p "#{__method__} passed"
end

module P2Enumerable
	def p2find_index
		cnt = 0
		p2each do | e |
			if (yield (e)) == true
				return cnt
			end
			cnt += 1
		end
		return nil
	end
end

test_p2find_index

def test_p2first
	r = [1,2,3,4].p2first(2)
	raise "#{__method__} error" if r != [1, 2]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2first ( n )
		res = []
		cnt = 1
		p2each do | e |
			if cnt <= n
				res << e
			end
			cnt += 1
		end
		return res
	end
end

test_p2first

def test_group_by
	a = [1,2,3,4,5,6]
	r = a.p2group_by { |i| i%3 }   #=> {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
	raise "#{__method__} error" if r != {0=>[3, 6], 1=>[1, 4], 2=>[2, 5]}
	p "#{__method__} passed"
end

module P2Enumerable
	def p2group_by
		h = {}
		p2each do | e |
			key = yield ( e )
			if h.key?(key)
				h[key] << e
			else
				h[key] = [e]
			end
		end
		return h
	end
end

test_group_by

def test_p2inject
	r = [1,2,3].p2inject(0) { |s, e| s + e}
	raise "#{__method__} error" if r != 6
	p "#{__method__} passed"
end

module P2Enumerable
	def p2inject ( init , &blk)
		r = init
		p2each do | e |
			r = blk.call(r, e )
		end
		return r
	end
end

test_p2inject

def test_p20inject
	r = [1,2,3].p2inject {|s, e| s + e}
	raise "#{__method__} error" if r != 6
	p "#{__method__} passed"
end

module P2Enumerable
	def p2inject( &blk )
		first = true
		r = nil
		p2each do | e |
			if first
				r = e
				first = false
			else
				r = blk.call(r, e)
			end
		end
		return r
	end
end

test_p20inject

def test_p2minmax
	a = %w(albatross dog horse)
	r = a.p2minmax { |a, b| a.length <=> b.length }
	raise "#{__method__} error" if r != ["dog", "albatross"]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2minmax( &blk )
		res = []
		tmax = self[ 0 ]
		tmin = self[ 0 ]
		p2each do | e |
			if (blk.call(e, tmax)) == 1
				tmax = e
			end
			if (blk.call(e, tmin)) == -1
				tmin = e
			end
		end
		res << tmin
		res << tmax
		return res
	end
end

test_p2minmax

def test_p2minmax_by
	a = %w(albatross dog horse)
	r = a.p2minmax_by { |x| x.length }
	raise "#{__method__} error" if r != ["dog", "albatross"]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2minmax_by( &blk )
		tmax = self[ 0 ]
		tmin = self[ 0 ]
		res = []
		p2each do | e |
			if (blk.call(e) > blk.call(tmax))
				tmax = e
			end
			if (blk.call(e) < blk.call(tmin))
				tmin = e
			end
		end
		res << tmin
		res << tmax
		return res
	end
end

test_p2minmax_by

def test_p2partition
	a = [1, 2, 3, 4, 5, 6]
	r = a.p2partition { |v| v.even? }
	raise "#{__method__} error" if r != [[2, 4, 6], [1, 3, 5]]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2partition( &blk )
		res = []
		resT = []
		resF = []
		p2each do | e |
			if blk.call(e)
				resT << e
			else
				resF << e
			end
		end
		res << resT
		res << resF
		return res
	end
end

test_p2partition

def test_p2reject
	r = [1, 2, 3, 4, 5].p2reject { |num| num.even? }
	raise "#{__method__} error" if r != [1, 3, 5]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2reject
		res = []
		p2each do | e |
			if (yield (e)) == false
				res << e
			end
		end
		return res
	end
end

test_p2reject

def test_p2take
	a = [1, 2, 3, 4, 5, 0]
	r = a.p2take(3)
	raise "#{__method__} error" if r != [1, 2, 3]
	p "#{__method__} passed"
end

module P2Enumerable
	alias p2take p2first
end

test_p2take

def test_p2take_while
	a = [1, 2, 3, 4, 5, 0]
	r = a.p2take_while { |i| i < 3 }
	raise "#{__method__} error" if r != [1, 2]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2take_while( &blk )
		res = []
		p2each do | e |
			if (blk.call(e)) == false
				return res
			else
				res << e
			end
		end
		return res
	end
end

test_p2take_while

def test_p2to_a
	r = { 'a'=>1, 'b'=>2, 'c'=>3 }.p2to_a
	raise "#{__method__} error" if r != [["a", 1], ["b", 2], ["c", 3]]
	p "#{__method__} passed"
end

module P2Enumerable
	alias p2to_a p2entries
end

test_p2to_a

def test_p2to_h
	a = [1, 2, 3, 4]
	r = a.collect{|a|[a,(a * 2)]}.p2to_h
	raise "#{__method__} error" if r != {1=>2, 2=>4, 3=>6, 4=>8}
	p "#{__method__} passed"
end

module P2Enumerable
	def p2to_h
		res = Hash.new
		p2each do | e |
			if e.is_a? Hash
				res[e.keys[0]] = e.values[0]
			else
				res[e[0]] = e[1]
			end
		end
		return res
	end
end

test_p2to_h

def test_p2min
	a = %w(albatross dog horse)
	r = a.p2min { |a, b| a.length <=> b.length }
	raise "#{__method__} error" if r != "dog"
	p "#{__method__} passed"
end

module P2Enumerable
	def p2min( &blk )
		res = self[0]
		p2each do | e |
			if (blk.call(e, res)) < 0
				res = e;
			end
		end
		return res
	end
end

test_p2min

# def test_p2min2
# 	a = %w(albatross dog horse)
# 	r = a.p2min(2) { |a, b| a.length <=> b.length }
# 	raise "#{__method__} error" if r != ["dog", "horse"]
# 	p "#{__method__} passed"
# end

# module P2Enumerable
# 	def p2min( n, &blk )
# 		res = self.p2to_a
# 		return res.sort.p2take(n)
# 	end
# end

# test_p2min2


def test_p2none?
	a = %w{ant bear cat}
	r = a.p2none? { |word| word.length == 5 } #=> true
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end

module P2Enumerable
	def p2none?
		p2each do | e |
			if (yield e) == true
				return false
			end
		end
		return true
	end
end

test_p2none?

def test_p2one?
	a = %w{ant bear cat}
	r = a.p2one? { |word| word.length == 4 }  #=> true
	raise "#{__method__} error" if r != true
	p "#{__method__} passed"
end

module P2Enumerable
	def p2one?
		p2each do | e |
			if (yield e) == true
				return true
			end
		end
		return false
	end
end

test_p2one?

def test_p2sort
	a = %w(rhea kea flea)
	r = a.p2sort          #=> ["flea", "kea", "rhea"]
	raise "#{__method__} error" if r != ["flea", "kea", "rhea"]
	p "#{__method__} passed"
end

module P2Enumerable
	def p2sort( &blk )
		res = self.p2to_a
		return res.sort!(&blk)
	end
end

test_p2sort

# def test_p2sort_by
# 	a = %w{apple pear fig}
# 	r = a.p2sort_by { |word| word.length}
# 	raise "#{__method__} error" if r != ["fig", "pear", "apple"]
# 	p "#{__method__} passed"
# end

# module P2Enumerable
# 	def p2sort_by
# \\
# 	end
# end

# test_p2sort_by
