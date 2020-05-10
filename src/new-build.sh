cobc -C -x -free hello.cob -o tmp/hello.c
cat say.c >> tmp/hello.c
cobc -x -o hello tmp/hello.c 