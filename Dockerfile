FROM ruby:2.5

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN gem install twitter_ebooks
RUN ebooks new ebooks


RUN mkdir template \
    && mkdir config \
    && mkdir app

COPY config.yaml.example /template/config.yaml.example
COPY bots.rb /app/bots.rb
COPY bots.rb /ebooks/bots.rb

COPY run.sh /
RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]