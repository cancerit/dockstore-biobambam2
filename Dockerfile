FROM  ubuntu:14.04

MAINTAINER  keiranmraine@gmail.com

LABEL uk.ac.sanger.cgp="Cancer Genome Project, Wellcome Trust Sanger Institute" \
      version="2.0.72" \
      description="bamtofastq program from biobambam2"

USER  root

ENV OPT /opt/wtsi-cgp
ENV PATH $OPT/bin:$PATH
ENV LD_LIBRARY_PATH $OPT/lib

RUN adduser --disabled-password --gecos '' ubuntu && chsh -s /bin/bash && mkdir -p /home/ubuntu

RUN mkdir -p $OPT/bin

ADD build/apt-build.sh build/
RUN bash build/apt-build.sh

ADD build/biobambam2-build.sh build/
RUN bash build/biobambam2-build.sh && \
  rsync -rl biobambam/bin $OPT/. && \
  rsync -rl biobambam/include $OPT/. && \
  rsync -rl biobambam/lib $OPT/. && \
  rsync -rl biobambam/share $OPT/. && \
  rm -rf biobambam
