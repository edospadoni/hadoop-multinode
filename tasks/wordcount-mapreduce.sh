#!/bin/bash

# create input files 
mkdir input_local
echo "Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?" > input_local/lorem
echo "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum." > input_local/ipsum

# create input directory on HDFS
hadoop fs -mkdir -p input

# put input files to HDFS
hdfs dfs -put ./input_local/* input

# run wordcount
hadoop jar \
        $HADOOP_HOME/share/hadoop/mapreduce/sources/hadoop-mapreduce-examples-2.8.2-sources.jar \
        org.apache.hadoop.examples.WordCount \
        input output

# print the input files
echo -e "Content of lorem:"
hdfs dfs -cat input/lorem

echo -e "\nContent of ipsum:"
hdfs dfs -cat input/ipsum

# print the output of wordcount
echo -e "\nWordcount output:"
hdfs dfs -cat output/part-r-00000

# clean files
rm -rf input_local
hadoop fs -rm -r -f input
hadoop fs -rm -r -f output
