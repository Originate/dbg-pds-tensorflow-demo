FROM gcr.io/tensorflow/tensorflow

RUN apt-get update && apt-get install --no-install-recommends \
  wget \
  && rm -rf /var/lib/apt/lists/*

RUN pip install awscli keras hdbscan statsmodels seaborn

RUN mkdir /data 








