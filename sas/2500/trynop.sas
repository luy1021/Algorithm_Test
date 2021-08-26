proc contents data = WORK.TRYnop;
	run;

proc format;
value melon_seeds_l 
  1="caramel"
  2="red dates" 
  3="origin"
  4="nonpurchase";
run;

proc freq data = WORK.TRYnop;
	format melon_seeds melon_seeds_l.;
	table melon_seeds;
run;

proc means data = WORK.TRYnop;
	format melon_seeds melon_seedsl.;
	var price= WORK.TRYnop;
	run;

proc logistic data = WORK.TRYnop;
	model melon_seeds = price/ link = glogit;
run;
