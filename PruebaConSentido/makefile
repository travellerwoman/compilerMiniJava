compiler: parser.yy scaner.flex
		bison -v -d parser.yy
		flex scaner.flex
		g++ -g -c parser.tab.cc -std=c++14
		g++ -g -ocompiler parser.tab.o lex.yy.c main.cc -std=c++14

clean:
		rm -f parser.tab.* lex.yy.c* compiler stack.hh tree.dot tree.pdf
		rm -R compiler.dSYM
		rm -f Result.txt

runFactorial: compiler
	./compiler < factorial.java > Resfactorial.txt

runBinaryTree: compiler
	./compiler < binarysearch.java > Resbinarysearch.txt

tree: 
		 dot -Tpdf tree.dot -otree.pdf

