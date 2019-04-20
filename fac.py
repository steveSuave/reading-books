def fac_recur(x):
	if x==1:
		return 1
	else:
		return x*fac_recur(x-1)


def fac_iter(target,counter=1,product=1):
	if target==counter:
		return product
	else:
		return fac_iter(target,counter+1,product*(counter+1))


#print(fac_recur(5))
print(fac_iter(5))
