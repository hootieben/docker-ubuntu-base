FROM ubuntu:focal AS base
RUN apt-get -q update\
  && apt-get -q -y install \
  unzip \
  git \
  curl \
  python3-pip \
  jq\
  && apt clean\
  && rm -rf /var/lib/apt/lists/*

FROM base AS aws
RUN pip3 install --user aws-sam-cli\
    && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"\
    && unzip awscliv2.zip\
    && ./aws/install -i ~/.local/aws-cli -b ~/.local/bin

FROM base
ENV PATH=/root/.local/bin:$PATH
COPY --from=aws /root/.local /root/.local

ENV PATH=/root/.local/bin:$PATH
CMD ["/bin/bash"]
