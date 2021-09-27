FROM ubuntu:20.04

RUN  apt update && apt install python2 python3 python3-pip git wget curl pcregrep libpcre++-dev python-dev yara gnupg -y && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5E80511B10C598B8 && echo "deb http://ppa.launchpad.net/gift/stable/ubuntu focal main " > /etc/apt/sources.list.d/gift.list && apt update &&apt install plaso-tools bulk-extractor -y 
RUN git clone https://github.com/CrowdStrike/SuperMem.git /app && cd /app && pip3 install -r requirements.txt && chmod +x ./winSuperMem.py && echo "python3 /app/winSuperMem.py" > /usr/bin/winSuperMem && mkdir /work
RUN wget https://s3.amazonaws.com/build-artifacts.floss.flare.fireeye.com/travis/linux/dist/evtxtract -O /usr/local/bin/evtxtract && chmod +x /usr/local/bin/evtxtract
RUN git clone https://github.com/volatilityfoundation/volatility3.git /opt/vol3 && chmod +x /opt/vol3/vol.py && ln -s /opt/vol3/vol.py /usr/bin/vol3
RUN git clone https://github.com/volatilityfoundation/volatility.git /tmp/vol2 && cd /tmp/vol2 && python setup.py install && git clone https://github.com/volatilityfoundation/community.git /usr/share/volatility/plugins/community
WORKDIR /work