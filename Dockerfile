FROM  alpine:3.7

MAINTAINER  keiranmraine@gmail.com

LABEL uk.ac.sanger.cgp="Cancer Genome Project, Wellcome Trust Sanger Institute" \
      version="1.0.0" \
      description="Dockstore.org mappings for biobambam2 tools"

USER  root

ENV OPT /opt/wtsi-cgp
ENV PATH $OPT/bin:$PATH


RUN apk update\
  && apk upgrade\
  && apk add --no-cache\
  autoconf\
  automake\
  bash\
  curl\
  file\
  g++\
  libc6-compat\
  libtool\
  make\
  musl-dev\
  rsync\
  zlib-dev

ADD build/biobambam2-build.sh build/
RUN bash build/biobambam2-build.sh && \
  rsync -rl biobambam/bin $OPT/. && \
  rsync -rl biobambam/include $OPT/. && \
  rsync -rl biobambam/lib $OPT/. && \
  rsync -rl biobambam/share $OPT/. && \
  rm -rf biobambam

RUN addgroup -S cgp && adduser -G cgp -S cgp

USER cgp
WORKDIR /home/cgp

CMD ["/bin/bash"]
