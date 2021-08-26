proc contents data = WORK.TRY500;
	run;

proc format;
value melon_seeds_l 
  1="caramel"
  2="red dates" 
  3="origin"
  4="nonpurchase";
run;

proc freq data = WORK.TRY500;
	format melon_seeds melon_seeds_l.;
	table melon_seeds;
run;

proc means data = WORK.TRY500;
	format melon_seeds melon_seedsl.;
	var price lnCD1= WORK.TRY500;
	run;

proc logistic data = WORK.TRY500;
	model melon_seeds = price ln/ link = glogit;
run;
