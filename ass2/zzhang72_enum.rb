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
			res = []
			res[0] = self.keys[i]
			res[1] = self.values[i]
			blk.call(res)
		end
	end
end

module P2Enumerable
	def p2all?
		p2each do | e |
			res = yield( e )
			if res == false || res == nil
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

module P2Enumerable
  def p2count (p = nil)
    r = 0
    if p == nil
      p2each do | e |
        res = yield ( e )
        if res != false
          r += 1
        end
      end
    else
      p2each do | e |
        if e == p
          r += 1
        end
      end
    end
    return r
  end
end

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

module P2Enumerable
  def p2drop_while
    res = []
    flag = false
    p2each do | e |
      if flag
        res << e
      elsif not yield ( e )
        res << e
        flag = true
      end
    end
    return res
  end
end

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

module P2Enumerable
	def p2entries (args = nil)
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

module P2Enumerable
	alias p2find p2detect
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

module P2Enumerable
  def p2first ( n = nil )
    if n == nil and (self == [] or self == {})
      return nil
    else
      res = []
      cnt = 1
      tn = n
      if n == nil
        tn = 1
      end
      p2each do | e |
        if cnt <= tn
          res << e
        end
        cnt += 1
      end
      if n == nil
        return res[0]
      else
        return res
      end
    end
  end
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

module P2Enumerable
	def p2inject ( init , &blk)
		r = init
		p2each do | e |
			r = blk.call(r, e )
		end
		return r
	end
end

module P2Enumerable
	def p2para0inject( &blk )
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

module P2Enumerable
  def p2minmax( &blk )
    res = []
    tmax = 0
    tmin = 0
    p2each do | e |
      tmax = e
      tmin = e
    end
    if blk != nil
      p2each do | e |
        if (blk.call(e, tmax)) == 1
          tmax = e
        end
        if (blk.call(e, tmin)) == -1
          tmin = e
        end
      end
    else
      p2each do | e |
        if e > tmax
          tmax = e
        end
        if e < tmin
          tmin = e
        end
      end
    end
    res << tmin
    res << tmax
    return res
  end
end

module P2Enumerable
	def p2minmax_by( &blk )
		tmax = nil
		tmin = nil
		flag = true
		res = []
		p2each do | e |
			if flag
				tmax = e
				tmin = e
				flag = false
			end
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

module P2Enumerable
	alias p2take p2first
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

module P2Enumerable
	alias p2to_a p2entries
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

module P2Enumerable
	def p2min( &blk )
		res = nil
		flag = true
		p2each do | e |
			if flag
				res = e
				flag = false
			elsif (blk.call(e, res)) < 0
				res = e;
			end
		end
		return res
	end
end

module P2Enumerable
	def p2max( &blk )
		res = nil
		flag = true
		p2each do | e |
			if flag
				res = e
				flag = false
			elsif (blk.call(e, res)) > 0
				res = e;
			end
		end
		return res
	end
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

module P2Enumerable
	def p2sort( &blk )
		res = self.p2to_a
		return res.sort!(&blk)
	end
end
