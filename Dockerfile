FROM ruby:2.5

ENV TZ=Europe/Berlin
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV USER=simonszu

RUN apt-get update \
    && apt-get install -y \
    cron \
    gettext \
    && rm -rf /var/lib/apt/lists*

RUN gem install twitter_ebooks
RUN ebooks new ebooks


RUN mkdir template \
    && mkdir app

COPY ebooksrc /template/ebooksrc
COPY bots.rb /template/bots.rb

COPY import.sh /ebooks/import.sh
RUN chmod +x /ebooks/import.sh

COPY cron /etc/cron.d/cron
RUN chmod +x /etc/cron.d/cron

COPY run.sh /
RUN chmod +x /run.sh \
    && touch /var/log/cron.log

WORKDIR /ebooks

ENTRYPOINT ["/run.sh"]