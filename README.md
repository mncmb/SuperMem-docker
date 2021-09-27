# SuperMem-docker

Just a quick and dirty way to demonstrate that SuperMem can be dockerized still need some changes, optimalization. 

to build
` git clone https://github.com/takov751/SuperMem-docker && docker build -t supermem ./SuperMem-docker/.`

to run
`docker run --rm -v "$PWD":/work -ti supermem bash`

In the container   syntax just changed from 

`python3 winSuperMem.py -f memdump.mem -o output/ -tt 1` 

to 

`winSuperMem -f memdump.mem -o output/ -tt 1`