-- Load the CSV file
salesTable = LOAD '/root/sales.csv' USING PigStorage(',') AS (Product:chararray,Price:chararray,Payment_Type:chararray,Name:chararray,City:chararray,State:chararray,Country:chararray);
-- Group data using the country column
GroupByCountry = GROUP salesTable BY Country;
-- Generate result format
CountByCountry = FOREACH GroupByCountry GENERATE CONCAT((chararray)$0, CONCAT(':', (chararray)COUNT($1)));
-- To remove old output folder
rmf /root/activity3local_result;
-- Save result in HDFS folder
STORE CountByCountry INTO '/root/activity3local_result' USING PigStorage(',');
