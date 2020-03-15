SPHERE_FINAL_FILE="flyspeck_dir/sphere_final.ml"
INEQ_FINAL_FILE="flyspeck_dir/ineq_final.ml"
TRANSCEND_DIR="transcend_sos"
PARSER_DIR="Sphere_parser"
all:
	cd $(PARSER_DIR); make;\
	if [ -f ../$(SPHERE_FINAL_FILE) ] && [ -f ../$(INEQ_FINAL_FILE) ];\
	then\
		echo "sphere_final exists";\
	else\
		echo "creating sphere_final";\
		./sphere_parser.native;\
	fi;\
	cd ..;ocamlbuild -use-ocamlfind nlcertify.native;\
	mv nlcertify.native nlcertify;\
	cd coq; make; cd ..;
byte:
	cd $(PARSER_DIR); make;\
	if [ -f ../$(SPHERE_FINAL_FILE) ] && [ -f ../$(INEQ_FINAL_FILE) ];\
	then\
		echo "sphere_final exists";\
	else\
		echo "creating sphere_final";\
		./sphere_parser.native;\
	fi;\
	cd ..;ocamlbuild -use-ocamlfind nlcertify.byte;\
	mv nlcertify.byte nlcertify;
clean:
	cd $(PARSER_DIR); make clean;\
  cd ..; \rm -rf _build nlcertify
