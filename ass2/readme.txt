Author: Zhizhou Zhang
Course: CSC 253

how to run:
	open the terminal and use normal ruby command to run, for some part of unit test,
	may cancel the comment signal(#xxxxx) first from text editor then run.

how iteration is stopped:
1. traversal the whole: collect, collect_concat, count, cycle, detect, each_cons, each_slice, each_with_index, entries, find_all, group_by, inject, minmax, minmax_by, partition, reject, to_a and to_h

2. when specific condition happens: all?, any?, drop_while, find_index, take_while
3. when the iteration reaches to the parameter: drop, first, take

extra credit:
    implement the following method:
    	min
    	max
    	none?
    	one?
    	sort?

notice:
	for the P2Enumerable unit test, I've done the whole part, just except some function which return nil like cycle and each_cons, I think to mock an output and compare it with standard output isn't very useful, so I didn't define the test function or they will interfere with other unit test(like infinite loop or a piles of output, which is very messy), so if you wanna to check that, please cancel the comments.


references:
	several functions and tests are derived from Professor Chen Ding's demo code, including P2each for Array and P2inject(as long as P2para0inject). Some test cases are copied from the ruby website: ruby-doc.org/core-2.2.3/Enumerable.html