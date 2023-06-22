FROM scrolltech/cuda-go-rust-builder:cuda-11.7.1-go-1.19-rust-nightly-2022-12-10 as builder
WORKDIR /
COPY halo2-gpu /halo2-gpu
COPY scroll /scroll
RUN echo 'paths = ["/halo2-gpu/halo2_proofs"]' > /root/.cargo/config
RUN echo "/scroll/roller/prover/lib" > /etc/ld.so.conf.d/a.conf && ldconfig
ENV LD_LIBRARY_PATH /usr/local/cuda/lib64:$LD_LIBRARY_PATH
RUN cd /scroll/roller && make libzkp && go test -tags="gpu ffi" -c prover/prover_test.go
RUN cd /scroll/coordinator && make libzkp && go test -tags="gpu ffi" -c coordinator/verifier_test.go

FROM nvidia/cuda:11.7.1-runtime-ubuntu22.04
WORKDIR /
COPY --from=builder /scroll/roller/prover.test /
COPY --from=builder /scroll/coordinator/verifier.test /