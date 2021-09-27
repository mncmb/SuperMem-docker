# SuperMem-docker

Just a quick and dirty way to demonstrate that SuperMem can be dockerized still need some changes, optimalization. 

to build
` git clone https://github.com/takov751/SuperMem-docker && docker build -t supermem ./SuperMem-docker/.`

to run
`docker run --rm -v "$PWD":/work -ti supermem bash`

in there from `python3 winSuperMem.py -f memdump.mem -o output/ -tt 1`  syntax just changed to this `winSuperMem -f memdump.mem -o output/ -tt 1`