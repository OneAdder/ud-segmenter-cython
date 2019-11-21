PYTHON_VERSION := $(shell python3 -c "import sys; print(sys.version[:3])")

base_sample.so split.so:
	cython3 src/base_sample.pyx -o base_sample.c
	gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing -I/usr/include/python$(PYTHON_VERSION) -o base_sample.so base_sample.c
	rm base_sample.c
	cython3 src/split.pyx -o split.c
	gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing -I/usr/include/python$(PYTHON_VERSION) -o split.so split.c
	rm split.c
