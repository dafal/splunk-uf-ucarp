FROM splunk/universalforwarder:latest

RUN apt-get update && apt-get install -y ucarp \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /etc/ucarp \
	&& cp /usr/share/doc/ucarp/examples/vip-down.sh /etc/ucarp/vip-down.sh \
	&& chmod +x /etc/ucarp/vip-down.sh \
	&& cp /usr/share/doc/ucarp/examples/vip-up.sh /etc/ucarp/vip-up.sh \
	&& chmod +x /etc/ucarp/vip-up.sh
	
RUN sed -i '4i/usr/sbin/ucarp --interface=${UCARP_INTERFACE} --srcip=${UCARP_SOURCEADDRESS} --vhid=${UCARP_VHID} --pass=${UCARP_PASS} --addr=${UCARP_VIRTUALADDRESS} --upscript=/etc/ucarp/vip-up.sh --downscript=/etc/ucarp/vip-down.sh --xparam=${UCARP_VIRTUALPREFIX} --nomcast --daemonize ${UCARP_OPTS}' /sbin/entrypoint.sh