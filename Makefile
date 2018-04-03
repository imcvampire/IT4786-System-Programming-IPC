CXX=gcc
OUT_DIR=bin
PROCESS_PIPE_DIR=process-pipe
PIPE_CALL_DIR=pipe-call
FIFO_DIR=fifo
MKDIR_P=mkdir -p

all: clean directories process-pipe pipe-call fifo

directories: ${OUT_DIR}

${OUT_DIR}:
	${MKDIR_P} ${OUT_DIR}
	${MKDIR_P} ${OUT_DIR}/${PROCESS_PIPE_DIR}
	${MKDIR_P} ${OUT_DIR}/${PIPE_CALL_DIR}
	${MKDIR_P} ${OUT_DIR}/${FIFO_DIR}

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

pipe-producer-consumer: ${PIPE_CALL_DIR}/producer.c ${PIPE_CALL_DIR}/consumer.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/producer ${PIPE_CALL_DIR}/producer.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/consumer ${PIPE_CALL_DIR}/consumer.c

pipe-as-stdout-stdin: ${PIPE_CALL_DIR}/pipe-as-stdout-stdin.c
	${CXX} -o ${OUT_DIR}/${PIPE_CALL_DIR}/pipe-as-stdout-stdin ${PIPE_CALL_DIR}/pipe-as-stdout-stdin.c

.PHONY: pipe-call simple producer-consumer pipe-as-stdout-stdin

fifo: create open fifo-producer-consumer

create: ${FIFO_DIR}/create.c
	${CXX} -o ${OUT_DIR}/${FIFO_DIR}/create ${FIFO_DIR}/create.c

open: ${FIFO_DIR}/open.c
	${CXX} -o ${OUT_DIR}/${FIFO_DIR}/open ${FIFO_DIR}/open.c

fifo-producer-consumer: ${FIFO_DIR}/producer.c ${FIFO_DIR}/consumer.c
	${CXX} -o ${OUT_DIR}/${FIFO_DIR}/producer ${FIFO_DIR}/producer.c
	${CXX} -o ${OUT_DIR}/${FIFO_DIR}/consumer ${FIFO_DIR}/consumer.c

.PHONY: fifo create open fifo-producer-consumer
