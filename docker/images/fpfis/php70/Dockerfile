FROM centos:6
MAINTAINER Gregory Boddin

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer
ENV COMPOSER_VERSION 1.3.1

RUN curl http://repo.ne-dev.eu/el/6/fpfis.repo > /etc/yum.repos.d/fpfis.repo
RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN yum update -y && yum install -y mysql rsync patch zip unzip git  httpd php70e-7.0.14 mod_php70e php70e-gd php70e-cli php70e-imap php70e-intl php70e-ldap php70e-mbstring php70e-mcrypt php70e-mysqlnd  php70e-opcache php70e-pdo php70e-soap php70e-xml php70e-pgsql php70e-pecl-redis && yum clean all

RUN curl -s -f -L -o /tmp/installer.php https://raw.githubusercontent.com/composer/getcomposer.org/2091762d2ebef14c02301f3039c41d08468fb49e/web/installer \
 && php -r " \
    \$signature = '55d6ead61b29c7bdee5cccfb50076874187bd9f21f65d8991d46ec5cc90518f447387fb9f76ebae1fbbacf329e583e30'; \
    \$hash = hash('SHA384', file_get_contents('/tmp/installer.php')); \
    if (!hash_equals(\$signature, \$hash)) { \
        unlink('/tmp/installer.php'); \
        echo 'Integrity check failed, installer is either corrupt or worse.' . PHP_EOL; \
        exit(1); \
    }" \
 && php /tmp/installer.php --no-ansi --install-dir=/usr/local/bin --filename=composer --version=${COMPOSER_VERSION} \
 && rm /tmp/installer.php \
 && composer --ansi --version --no-interaction
ADD envvars /etc/httpd/envvars
ADD php.ini /etc/php.d/fpfis.ini
ADD run.sh /run.sh
CMD /run.sh

