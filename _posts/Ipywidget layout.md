#  Ipywidget layout

- create new conda env and install `ipywidgets`

```bash
conda create -n widget python
conda activate widget
conda install -c conda-forge ipywidgets
conda install -c conda-forge nodejs
jupyter labextension install @jupyter-widgets/jupyterlab-manager

#install bqplot, need to install from source
pip install -e git+git://github.com/bloomberg/bqplot.git@master#egg=bqplot
```

