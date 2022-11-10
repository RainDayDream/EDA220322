#!/bin/bash
if [ -a "$1" ]; then
    echo 正在求解 $1 
    # echo 预处理... 
    quiet=$(/home/eda220322/abc-try/abc-master/abc -q "read_aiger $1; write_cnf t.cnf; quit")
    # echo 正在求解...
    output_result=$(./handin/cadical -q -t 20 t.cnf)
    if [ "$output_result" = "c UNKNOWN" ];then #千万不要动此行的任意一个空格
        # echo 再次处理...
        quiet=$(/home/eda220322/abc-try/abc-master/abc -q "read_aiger $1;resyn;choice;write_cnf t.cnf;quit")
        # echo 再次求解...choice;
        ./handin/cadical -q t.cnf
    else
        echo $output_result
    fi
else
    echo $1不存在
fi