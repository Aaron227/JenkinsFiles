
mongoexport --authenticationDatabase admin --host 10.218.222.52 --port 27017 -u admin -p 123456 --db runoob --collection stu --type json --out /opt/bigData/user/aaron/runoob/stu.json --limit 100

hdfs dfs -rm -r /opt/bigData/user/aaron/runoob/stu.json

hdfs dfs -put /opt/bigData/user/aaron/runoob/stu.json /opt/bigData/user/aaron/runoob/

Sql_file=tmp.ql

cat > $Sql_file <<EOFI
DROP TABLE IF EXISTS runoob.stu_tmp;
CREATE external TABLE IF NOT EXISTS runoob.stu_tmp
(
        tmp_str string

)
ROW FORMAT DELIMITED FIELDS TERMINATED BY '\t'
LOCATION '/opt/bigData/user/aaron/runoob';
EOFI

cat $Sql_file
hive -f $Sql_file
\rm -f $Sql_file
