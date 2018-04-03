CXX=gcc
OUT_DIR=bin
PROCESS_PIPE_DIR=process-pipe
PIPE_CALL_DIR=pipe-call
MKDIR_P=mkdir -p

all: clean directories process-pipe pipe-call

directories: ${OUT_DIR}

${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}
	${MKDIR_P} ${OUT_DIR}/${PROCESS_PIPE_DIR}
	${MKDIR_P} ${OUT_DIR}/${PIPE_CALL_DIR}

clean:
	rm -rf $(OUT_DIR)

.PHONY: directories clean

process-pipe: receive-output send-output

receive-output: ${PROCESS_PIPE_DIR}/receive-output.c
	${CXX} -o ${OUT_DIR}/${PROCESS_PIPE_DIR}/receive-output ${PROCESS_PIPE_DIR}/receive-output.c
send-output: ${PROCESS_PIPE_DIR}/send-output.c
	${CXX} -o ${OUT_DIR}/${PROCESS_PIPE_DIR}/send-output ${PROCESS_PIPE_DIR}/send-output.c

.PHONY: process-pipe receive-output send-output

pipe-call: simple producer-consumer pipe-as-stdout-stdin

simple: ${PIPE_CALL_DIR}/simple.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/simple ${PIPE_CALL_DIR}/simple.c

producer-consumer: ${PIPE_CALL_DIR}/producer.c ${PIPE_CALL_DIR}/consumer.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/producer ${PIPE_CALL_DIR}/producer.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/consumer ${PIPE_CALL_DIR}/consumer.c

pipe-as-stdout-stdin: ${PIPE_CALL_DIR}/pipe-as-stdout-stdin.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/pipe-as-stdout-stdin ${PIPE_CALL_DIR}/pipe-as-stdout-stdin.c

.PHONY: pipe-call simple producer-consumer pipe-as-stdout-stdin
