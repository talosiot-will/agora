SRC = $(wildcard ./*.ipynb)

it: 
	nbdev_read_nbs
	nbdev_build_lib
	nbdev_clean_nbs
	git status

docs_serve: docs
	cd docs && bundle exec jekyll serve

docs: $(SRC)
	nbdev_build_docs
	touch docs

test:
	nbdev_test_nbs

clean:
	rm -rf dist

github:
	act -P ubuntu-latest=github_workflow_tester

env:
	virtualenv .venv -p python3.8 --prompt "[agora] "
	. .venv/bin/activate && pip install jupyter jupyterlab nbdev
	. .venv/bin/activate && (jupyter labextension check @jupyter-widgets/jupyterlab-manager ||  jupyter labextension install @jupyter-widgets/jupyterlab-manager)
	. .venv/bin/activate && pip install -e .

server:
	. .venv/bin/activate && jupyter lab --ip 0.0.0.0


