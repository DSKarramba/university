PYTHON=python3
Z1=4
Z2=25

plots: module
	$(PYTHON) lab2.py $(Z1) $(Z2)

module:
	$(PYTHON) setup.py build_ext --inplace

clean:
	rm -rf build __pycache__ tf*.so
