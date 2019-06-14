FROM nginx

# Install main dependencies
RUN apt-get update && apt-get install apt-utils sudo gnupg2 sshpass openssh-server rsync vim -y
RUN mkdir /var/run/sshd

# Adding SSH web user
RUN adduser web --home /usr/share/nginx --disabled-password --gecos "Web User"
RUN chown web:web -R /usr/share/nginx
RUN echo web:ChangeMe$ | chpasswd


# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh

EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]