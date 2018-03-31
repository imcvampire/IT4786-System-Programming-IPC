CXX=gcc
OUT_DIR=bin
PROCESS_PIPE_DIR=process-pipe

MKDIR_P=mkdir -p

all: clean directories process-pipe

directories: ${OUT_DIR}

${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}
	${MKDIR_P} ${OUT_DIR}/${PROCESS_PIPE_DIR}

clean:
	rm -rf $(OUT_DIR)

.PHONY: directories clean

process-pipe: receive-output send-output

receive-output: ${PROCESS_PIPE_DIR}/receive-output.c
	${CXX} -o ${OUT_DIR}/${PROCESS_PIPE_DIR}/receive-output ${PROCESS_PIPE_DIR}/receive-output.c
send-output: ${PROCESS_PIPE_DIR}/send-output.c
	${CXX} -o ${OUT_DIR}/${PROCESS_PIPE_DIR}/send-output ${PROCESS_PIPE_DIR}/send-output.c

.PHONY: process-pipe receive-output send-output
