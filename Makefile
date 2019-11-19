PYTHON_VERSION=$(python3 -c "import sys; print(sys.version[:3])")$

base_sample.so:
	cython3 base_sample.pyx
	gcc -shared -pthread -fPIC -fwrapv -O2 -Wall -fno-strict-aliasing -I/usr/include/python3.7 -o base_sample.so base_sample.c
