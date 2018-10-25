FROM alpine:3.8

ENV KUBECTL_VERSION=1.12.1
ENV IBMCLOUDCLI_VERSION=0.10.1

WORKDIR "/root"

RUN apk update && \
    apk add --no-cache bash curl git && \
    mkdir /root/bin && \
    curl https://public.dhe.ibm.com/cloud/bluemix/cli/bluemix-cli/${IBMCLOUDCLI_VERSION}/IBM_Cloud_CLI_${IBMCLOUDCLI_VERSION}_amd64.tar.gz -o out.tar.gz && \
    tar xvzf out.tar.gz && \
    ./Bluemix_CLI/install && \
    ibmcloud plugin install container-service -r Bluemix && \
    rm out.tar.gz && \
    curl -LO https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
    mv kubectl /root/bin && \
    chmod +x /root/bin/kubectl

RUN echo 'export PS1="\[\e[34m\]IBM\[\e[m\]☁️  # "' > /root/.bashrc
RUN echo 'export PATH="$PATH:/root/bin"' >> /root/.bashrc
RUN echo 'cat /etc/motd' >> /root/.bashrc
RUN echo 'Thank you for using the IBM Cloud-Native Docker Container. In your first login, we suggest you ibmcloud login to authenticate against the IBM cloud API.' > /etc/motd

ENTRYPOINT ["bash"]
