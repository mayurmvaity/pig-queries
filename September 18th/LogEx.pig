log1 = load '/home/franklin/mapred-franklin-historyserver-ubuntu.log' using PigStorage() as (lines:chararray);

split log1 into log2 if SUBSTRING(lines,24,28) == 'INFO', log3 if SUBSTRING(lines,24,29) == 'ERROR', log4 if SUBSTRING(lines,24,28) == 'WARN';


grouplog2 = group log2 ALL;
grouplog3 = group log3 ALL;
grouplog4 = group log4 ALL;


countoflog2 = foreach grouplog2 generate COUNT(log2);
countoflog3 = foreach grouplog3 generate COUNT(log3);
countoflog4 = foreach grouplog4 generate COUNT(log4);


dump countoflog2;
dump countoflog3;
dump countoflog4;



infogrp = group log2 by SUBSTRING(lines,20,23);


infocount = foreach infogrp generate group, COUNT(log2);
infoorder = order infocount by $1;
dump infoorder;


errgrp = group log3 by SUBSTRING(lines,20,23);


errcount = foreach errgrp generate group, COUNT(log3);
errorder = order errcount by $1;
dump errorder;
