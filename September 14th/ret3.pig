
data00 = load '/home/franklin/2000.txt' using PigStorage(',') as (catno:long, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sept:double, oct:double, nov:double, dec:double);


dataSum00 = foreach data00 generate $0, $1, (jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec);



data01 = load '/home/franklin/2001.txt' using PigStorage(',') as (catno:long, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sept:double, oct:double, nov:double, dec:double);


dataSum01 = foreach data01 generate $0, $1, (jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec);


data02 = load '/home/franklin/2002.txt' using PigStorage(',') as (catno:long, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sept:double, oct:double, nov:double, dec:double);


dataSum02 = foreach data02 generate $0, $1, (jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec);


joined = join dataSum00 by ($0,$1), dataSum01 by ($0,$1), dataSum02 by ($0,$1);


rmcol = foreach joined generate $0, $1, $2, $5, $8;


totalSales = foreach rmcol generate $0, $1, ($2+$3+$4) as tsales;


ordersales = order totalSales by tsales desc;


top5sales = limit ordersales 5;


ordersalesMin = order totalSales by tsales asc;


min5sales = limit ordersalesMin 5;


store top5sales into '/home/franklin/pigops/ret3top5' using PigStorage(',');


store min5sales into '/home/franklin/pigops/ret3min5' using PigStorage(',');









