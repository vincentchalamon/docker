FROM circleci/android:api-28-alpha

USER root

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash; \
    export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"; \
    nvm install stable; \
    nvm use stable; \
    npm install -g react-native-cli detox-cli yarn
