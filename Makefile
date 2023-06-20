PARAMS_VERSION=params-0320
VK_VERSION=release-v0.3

pre_zkp:
	rm -rf ./assets
	docker build -t test_zkp:0.1 .
	mkdir -p ./assets/test_params ./assets/traces
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/${PARAMS_VERSION}/params20 -O ./assets/test_params/params20
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/${PARAMS_VERSION}/params26 -O ./assets/test_params/params26
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/release-1220/test_seed -O ./assets/test_seed
	wget https://circuit-release.s3.us-west-2.amazonaws.com/circuit-release/${VK_VERSION}/verify_circuit.vkey -O ./assets/agg_vk
	wget https://raw.githubusercontent.com/scroll-tech/test-traces/main/erc20/erc20_10_transfer.json -O ./assets/traces/erc20_10_transfer.json
	docker-compose up
