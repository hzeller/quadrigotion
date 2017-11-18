#!/bin/bash
# Create hierarchical schematic scheets with annotated numbers in blocks
# of 100 from a template.
##

if [ $# -ne 1 ] ; then
    echo "usage: $0 <count>" > /dev/stderr
    exit 1
fi
COUNT=$1

TEMPLATE=template/tmc2660-block.sch
OUT_BASE=tmc2660-block

for i in `seq 1 $COUNT` ; do
    cat $TEMPLATE \
	| sed "s/\(^F 0 \"[A-Z]\)1\([0-9]\+\)/\1${i}\2/g" \
        | sed "s/\(^L.*[A-Z]\)1\([0-9]\+\)/\1${i}\2/g" \
	      > ${OUT_BASE}-${i}00.sch
    echo "Created ${OUT_BASE}-${i}00.sch"
done
