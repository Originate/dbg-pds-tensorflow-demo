FROM tensorflow/tensorflow:2.1.0-py3-jupyter

RUN apt-get update && apt-get install --no-install-recommends \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN pip install awscli keras statsmodels seaborn scikit-learn && \
    pip uninstall -y enum34 && \
    pip install hdbscan && \
    pip install --upgrade ipython

ENV PYTHONIOENCODING=UTF-8

RUN mkdir /data 

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter notebook --notebook-dir=/notebooks/dbg-pds-demo --ip 0.0.0.0 --no-browser --allow-root"]

