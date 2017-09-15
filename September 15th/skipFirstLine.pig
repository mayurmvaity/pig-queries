
bag1 = load '/home/franklin/rankfile.txt' using PigStorage(',') as (id:int, name:chararray);


rankedBag = rank bag1;


filterbag = filter rankedBag by rank_bag1 > 1;


final = foreach filterbag generate $1, $2;

dump final;


