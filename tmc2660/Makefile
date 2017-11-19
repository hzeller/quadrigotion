# -*- Makefile -*-

FABS=tmc2660-quad-fab.zip

all : $(FABS)

# In case the original schematic is adapted.
tmc2660-block-100.sch: template/tmc2660-block.sch
	./create-blocks-from-template.sh 4

tmc2660-quad.sch: tmc2660-block-100.sch

%.zip : %.kicad_pcb
	python ../kicad-scripts/kicad-fab.py $*
	zip -r $@ $*

%-fab.kicad_pcb : %.kicad_pcb
	sed "s/%%gitversion%%/`git log --date=short --pretty=format:'%h@%cd' -n 1 $<`/" < $^ > $@

clean:
	rm -rf $(FABS) $(FABS:.zip=)
