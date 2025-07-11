FROM registry.cn-shanghai.aliyuncs.com/mooneep/node:14 as builder
RUN npm install -g cnpm --registry=https://registry.npm.taobao.org && \
    cnpm i -g hexo-cli
ADD ./ /home
WORKDIR /home
RUN cnpm i && hexo g

FROM registry.cn-shanghai.aliyuncs.com/mooneep/nginx:1.22
ADD ./conf/nginx/default.conf /etc/nginx/conf.d/
ADD ./conf/cert/* /etc/nginx/certs/
COPY --from=0 /home/public /var/www/

