# To test-build this dockerfile
#     docker build -f .gitpod.Dockerfile -t gitpod-dockerfile-test .
#
# To test-run this built dockerfile
#     docker run -it gitpod-dockerfile-test bash

FROM gitpod/workspace-full

ARG AWS_CLI_V2_URL='https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip'

# Install global stuff
RUN yarn global add @angular/cli
RUN yarn global add @ionic/cli
RUN yarn global add @nestjs/cli

# to use with gitmoji -c
RUN yarn global add gitmoji-cli

RUN yarn global add aws-cdk

# Root user needed for AWS-CLI install at least
USER root:root

# install aws-cli v2
# Can be confirmed with aws --version
# CLI will need environment variables 
#   - AWS_ACCESS_KEY_ID
#   - AWS_SECRET_ACCESS_KEY
#   - AWS_DEFAULT_REGION
RUN curl "${AWS_CLI_V2_URL}" -o "/tmp/awscliv2.zip" && \
  unzip /tmp/awscliv2.zip -d /tmp && \
  /tmp/aws/install

USER gitpod:gitpod

# Make all yarn-globally installed stuff avail for command line
RUN chmod +x $HOME/.yarn/bin/*
ENV PATH="$HOME/.yarn/bin:$PATH"