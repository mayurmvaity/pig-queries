txn = load '/home/franklin/txns1.txt' using PigStorage(',') as (txnid, txndate, custno:chararray, amount:double, cat, prod, city, state, type);


txn = foreach txn generate type, amount;


grptxn = group txn by type;



totalspend = foreach grptxn generate group, ROUND_TO(SUM(txn.amount),2) as total;





totalgrp = group totalspend all;


totalsales = foreach totalgrp generate SUM(totalspend.$1);




final = foreach totalspend generate $0, $1, ROUND_TO(($1/totalsales.$0)*100,2);

dump final;


store final into '/home/franklin/pigops/salesbytype' using PigStorage(',');
