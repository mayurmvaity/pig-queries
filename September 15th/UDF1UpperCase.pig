register udfpig.jar;

DEFINE ConvLowerToUpper pigpkg.UpperCase();

bag1 = load '/home/franklin/sample.txt' using PigStorage(',') as (name:chararray);

bag2 = foreach bag1 generate ConvLowerToUpper(name);

dump bag2;

