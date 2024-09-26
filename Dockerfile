FROM justb4/jmeter:5.5

ENV JMETER_HOME /opt/apache-jmeter-5.5
ENV PATH $JMETER_HOME/bin:$PATH

COPY scripts/performance-tests.jmx /jmeter/test.jmx

ENTRYPOINT ["jmeter", "-n", "-t", "/jmeter/test.jmx", "-l", "/jmeter/results/results.jtl", "-e", "-o", "/jmeter/results/report"]
