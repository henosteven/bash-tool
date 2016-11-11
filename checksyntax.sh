#!/bin/bash
##########################
## 检查修改过文件php语法##
##########################

phpbin="/usr/local/php/bin/php"
out=`git status`
branch=`echo $out | awk '{print $3}'`
echo "branch: ${branch}"

#提取modified文件处理
echo "modified files:"
tmpfilelist=`git status | grep 'modified' | awk '{print $3}'`
awk -v val="$tmpfilelist" -v php="$phpbin" 'BEGIN {
    info = val
    split(info, files, " ")
    for (i in files) {
        print "=========="
        print files[i]
        cmd= php" -l "files[i]
        system(cmd)
    }
}'

#提取new add 文件处理
echo "add files:"
tmpfilelist2=`git status   | sed -n '/Untracked files/,$p'  |sed -n '4,$p'|awk '{print $2}' | tac | sed -n '2,$p'`
awk -v val="$tmpfilelist2" -v php="$phpbin" 'BEGIN {
    info = val
        split(info, files, " ")                                                                              
        for (i in files) {
            print "=========="
                print files[i]
                cmd= php" -l "files[i]
                system(cmd)
        }
}'
