txn = load '/home/franklin/txns1.txt' using PigStorage(',') as (txnid, txndate,custno:chararray, amount:double, cat, prod, city,state,type);


txn = foreach txn generate custno,amount;


grptxn = group txn by custno;



totalspend = foreach grptxn generate group, ROUND_TO(SUM(txn.amount),2);



orderbytotal = order totalspend by $1 desc;

top10 = limit orderbytotal 10;



cust = load '/home/franklin/custs.csv' using PigStorage(',') as (custno:chararray, firstname,lastname,age:int, profession:chararray);

joined = join cust by $0, top10 by $0;



top10join = foreach joined generate $0,$1,$2,$3,$4,$6;



final = order top10join by $5 desc;

dump final;


store final into '/home/franklin/pigops/topten' using PigStorage(',');
