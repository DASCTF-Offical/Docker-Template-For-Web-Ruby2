FROM ruby:2-buster
COPY files /tmp/files/
RUN mv /tmp/files/flag.sh / && \
    mv /tmp/files/start.sh / && \
    chmod +x /flag.sh /start.sh && \
    rm -rf /tmp/files && \
    useradd app -m && \
    mkdir /app && \
    chown -R root:root /app && \
    chmod -R 755 /app && \
    sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list && \
	  sed -i '/security/d' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install nodejs npm -y && \
    npm config set registry https://registry.npm.taobao.org && \
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && \
    bundle config 'mirror.https://rubygems.org' 'https://gems.ruby-china.com/' && \
    npm config set registry https://registry.npm.taobao.org && \
    gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/ && \
    bundle config 'mirror.https://rubygems.org' 'https://gems.ruby-china.com/' && \
    su - app -c 'npm config set registry https://registry.npm.taobao.org' && \
    su - app -c 'gem sources --add https://gems.ruby-china.com/ --remove https://rubygems.org/' && \
    su - app -c "bundle config 'mirror.https://rubygems.org' 'https://gems.ruby-china.com/'" && \
    rm -rf /var/lib/apt/lists/*
WORKDIR /app
CMD /start.sh
