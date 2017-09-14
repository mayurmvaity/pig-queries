
data00 = load '/home/franklin/2000.txt' using PigStorage(',') as (catno:long, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sept:double, oct:double, nov:double, dec:double);



dataSum00 = foreach data00 generate $0, $1, (jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec);



data01 = load '/home/franklin/2001.txt' using PigStorage(',') as (catno:long, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sept:double, oct:double, nov:double, dec:double);



dataSum01 = foreach data01 generate $0, $1, (jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec);





data02 = load '/home/franklin/2002.txt' using PigStorage(',') as (catno:long, catname:chararray, jan:double, feb:double, mar:double, apr:double, may:double, jun:double, jul:double, aug:double, sept:double, oct:double, nov:double, dec:double);



dataSum02 = foreach data02 generate $0, $1, (jan+feb+mar+apr+may+jun+jul+aug+sept+oct+nov+dec);



joined = join dataSum00 by ($0,$1), dataSum01 by ($0,$1), dataSum02 by ($0,$1);



rmcol = foreach joined generate $0, $1, $2, $5, $8;



lossp = foreach rmcol generate $0, $1, ROUND_TO(($2-$3)/$2*100,2), ROUND_TO(($3-$4)/$3*100,2);



avgloss = foreach lossp generate $0, $1, ROUND_TO(($2+$3)/2,2) as loss;


lossfiltr = filter avgloss by loss >= 5;


store lossfiltr into '/home/franklin/pigops/ret2op' using PigStorage(',');
























