def fib_recur(n):
	if n==0:
		return 0
	if n==1:
		return 1
	else:
		return fib_recur(n-1)+fib_recur(n-2)


def fib_iter(n,a=0,b=1):
	if n==0:
		return a
	else:
		return fib_iter(n-1,b,a+b)
