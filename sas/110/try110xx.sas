proc contents data = WORK.TRY110xx;
	run;

proc format;
value melon_seeds_l 
  1="caramel"
  2="red dates" 
  3="origin"
  4="nonpurchase";
run;

proc freq data = WORK.TRY110xx;
	format melon_seeds melon_seeds_l.;
	table melon_seeds;
run;

proc means data = WORK.TRY110xx;
	format melon_seeds melon_seedsl.;
	var price xx= WORK.TRY110xx;
	run;

proc logistic data = WORK.TRY110xx;
	model melon_seeds = price xx/ link = glogit;
run;
