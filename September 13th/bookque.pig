bookdata = load '/home/franklin/book_data.txt' using PigStorage(',') as (bookid:int, price:int, authid:int);


bfiltered = filter bookdata by price >= 200;



authdata = load '/home/franklin/auth_data.txt' using PigStorage(',') as (authid:int,authname:chararray);


authfiltered = filter authdata by INDEXOF(authname,'J',0) == 0;


bookauthjoin = join bfiltered by authid, authfiltered by authid;

final = foreach bookauthjoin generate $0,$1,$2,$4;

store final into '/home/franklin/pigops/bookauthop' using PigStorage(',');

