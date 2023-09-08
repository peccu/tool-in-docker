FROM peccu/tool-in-docker:emacs-x

USER root
RUN yum install -y crontabs \
        && yum clean all
# RUN crontab -l | { cat - ; echo "* * * * * bash -c 'echo -n \"running on \" ; date' >> /tmp/cronlog"; } | crontab -
# RUN crontab -l | { cat - ; echo "0 * * * * bash -c 'echo -n \"running on \" ; date' >> /tmp/cronlog"; } | crontab -
RUN crontab -l | { cat - ; echo "0 0 * * * bash -c 'echo -n \"running on \" ; date' >> /tmp/cronlog"; } | crontab -
# 09:00 JST
RUN crontab -l | { cat - ; echo "0 0 01 * * run-parts /etc/cron.monthly >> /tmp/cronlog"; } | crontab -
RUN touch /tmp/cronlog

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "crond;tail -F /tmp/cronlog"]
