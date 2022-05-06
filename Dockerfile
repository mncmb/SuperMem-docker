FROM ubuntu:20.04

WORKDIR /tmp

RUN apt-get update \ 
 && apt-get install python2 python3 python3-pip git wget curl swig pcregrep libssl-dev libpcre++-dev python-dev yara gnupg -y \
 && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5E80511B10C598B8 \
 && echo "deb http://ppa.launchpad.net/gift/stable/ubuntu focal main " > /etc/apt/sources.list.d/gift.list \
 && apt-get update \
 && apt-get install plaso-tools bulk-extractor -y \
 && apt-get clean autoclean \
 && apt-get autoremove --yes

RUN git clone https://github.com/CrowdStrike/SuperMem.git /app \
 && cd /app \
 && pip3 install -r requirements.txt \
 && chmod +x ./winSuperMem.py \
 && echo -e 'python3 /app/winSuperMem.py "$@"' > /usr/bin/winSuperMem \
 && chmod +x /usr/bin/winSuperMem \
 && mkdir /work

RUN wget https://s3.amazonaws.com/build-artifacts.floss.flare.fireeye.com/travis/linux/dist/evtxtract -O /usr/local/bin/evtxtract \
 && chmod +x /usr/local/bin/evtxtract

RUN git clone https://github.com/volatilityfoundation/volatility3.git /opt/vol3 \
 && chmod +x /opt/vol3/vol.py \
 && ln -s /opt/vol3/vol.py /usr/bin/vol3

# necessary for some vol2 community plugins 
RUN curl https://bootstrap.pypa.io/pip/2.7/get-pip.py | python - && pip install distorm3==3.4.2 pycrypto dpapick pycoin yara construct==2.5.5-reupload lxml pefile simplejson 


# added link, so that vol2 location fits with the path specified in supermem 
# added a link so that community plugins / yarascan can find libyara at the right location
# deleted a single community plugin because an import conflicts with defined objects
RUN git clone https://github.com/volatilityfoundation/volatility.git /tmp/vol2 \
 && cd /tmp/vol2 && python setup.py install \
 && git clone https://github.com/volatilityfoundation/community.git /usr/share/volatility/plugins/community \
 && ln -s /usr/local/bin/vol.py /usr/bin/vol.py \ 
 && ln -s /usr/local/lib/python2.7/dist-packages/usr/lib/libyara.so /usr/lib/libyara.so \ 
 && rm -rf /usr/share/volatility/plugins/community/ThomasWhite 

WORKDIR /work
