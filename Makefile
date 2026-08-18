.PHONY: reproduce test clean

reproduce:
	python analysis/run_analysis.py

test:
	python tests/test_results.py

clean:
	rm -f results/tables/*.csv results/tables/*.json results/figures/*.png results/figures/*.svg

all: reproduce test
