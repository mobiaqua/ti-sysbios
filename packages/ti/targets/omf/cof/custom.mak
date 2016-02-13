#
#  Copyright 2015 by Texas Instruments Incorporated.
#  
#

include $(XDCROOT)/packages/xdc/bld/xdc_java.mak

CLASSES  = $(patsubst %.java,%,$(wildcard *.java))
JARFILE  = java/package.jar

JCPATH:=$(XDCROOT)/packages/xdc/rta/java/package.jar

.libraries: $(JARFILE)
$(JARFILE): $(patsubst %,$(CLASSDIR)/%.class,$(CLASSES))

clean::
	$(RM) $(JARFILE)

JTEST = java -classpath java/package.jar ti.targets.omf.cof.Coff
java.test: java/package.jar
	$(JTEST) tests/exes/java_test/hello.x64P 0x8000305c
	$(JTEST) tests/exes/java_test/hello.x55 0x36ba
	$(JTEST) tests/exes/java_test/hello.x55 0x4216	
	$(JTEST) tests/exes/java_test/hello.x28L 0x103e88 
	$(JTEST) tests/exes/java_test/hello.x28L 0x104082


#
#  @(#) ti.targets.omf.cof; 1,0,0,0; 12-11-2015 16:44:39; /db/ztree/library/trees/xdctargets/xdctargets-k07/src/ xlibrary

#

