txn = load '/home/franklin/txns1.txt' using PigStorage(',') as (txnid:long, txndate, custno:chararray, amount:double, cat, prod, city, state, type);

cust = load '/home/franklin/custs.txt' using PigStorage(',') as (custno:chararray, firstname:chararray, lastname: chararray, age:int, profession:chararray);

txn = foreach txn generate custno, amount;
cust = foreach cust generate custno, firstname;


joined = cogroup cust by custno, txn by custno;


final = foreach joined generate FLATTEN(cust.firstname), COUNT(txn), ROUND_TO(SUM(txn.amount),2);

store final into '/home/franklin/cgrp1op' using PigStorage(',');

dump final;
