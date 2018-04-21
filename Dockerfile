FROM ruby:2.5

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update \
    && apt-get install -y cron \
    && rm -rf /var/lib/apt/lists*

RUN gem install twitter_ebooks
RUN ebooks new ebooks


RUN mkdir template \
    && mkdir config \
    && mkdir app

COPY config.yaml.example /template/config.yaml.example
COPY ebooksrc /template/ebooksrc
COPY bots.rb /app/bots.rb

COPY run.sh /
RUN chmod +x /run.sh \
    && touch /var/log/cron.log

ENTRYPOINT ["/run.sh"]