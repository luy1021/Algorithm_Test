proc contents data = WORK.TRY;
	run;

proc format;
value melon_seeds_l 
  1="caramel"
  2="red dates" 
  3="origin"
  4="nonpurchase";
run;

proc freq data = WORK.TRY;
	format melon_seeds melon_seeds_l.;
	table melon_seeds;
run;

proc means data = WORK.TRY;
	format melon_seeds melon_seedsl.;
	var price ln= WORK.TRY;
	run;

proc logistic data = WORK.TRY;
	model melon_seeds = price ln/ link = glogit;
run;
