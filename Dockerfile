FROM tensorflow/tensorflow

RUN apt-get update && apt-get install --no-install-recommends \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN pip install awscli keras hdbscan statsmodels seaborn

# delete google cloud demos
RUN rm 1_hello_tensorflow.ipynb && \
    rm 2_getting_started.ipynb && \
    rm 3_mnist_from_scratch.ipynb  && \
    rm BUILD  && \
    rm LICENSE

RUN mkdir /data 








