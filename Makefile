SCROLL_BRANCH=zk_test_automation
HALO2_GPU_COMMIT=c5860f4e
PARAMS_VERSION=release-1220
VK_VERSION=release-0215

init_repo:
	git clone -b ${SCROLL_BRANCH} git@github.com:scroll-tech/scroll.git
	git clone git@github.com:scroll-tech/halo2-gpu.git && cd halo2-gpu && git checkout ${HALO2_GPU_COMMIT}

test_zkp:
	rm -rf ./assets
	docker build -t test_zkp:0.1 .
	mkdir -p ./assets/test_params ./assets/traces
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/${PARAMS_VERSION}/test_params/params19 -O ./assets/test_params/params19
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/${PARAMS_VERSION}/test_params/params26 -O ./assets/test_params/params26
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/release-1220/test_seed -O ./assets/test_seed
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/${VK_VERSION}/verify_circuit.vkey -O ./assets/agg_vk
	wget https://raw.githubusercontent.com/scroll-tech/test-traces/main/erc20/erc20_10_transfer.json -O ./assets/traces/erc20_10_transfer.json
	docker-compose up
