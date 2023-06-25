# test_zkp

## Requires
- Docker
- CPU machine
- Docker nvidia drive

## Choose your versions
```
$ vim Makefile
SCROLL_BRANCH=zk_test_automation
HALO2_GPU_COMMIT=c5860f4e
PARAMS_VERSION=params-0320
VK_VERSION=release-v0.3
```

## Download halo2_gpu and scroll repos
```
make init_repo
```

## Run test prove and verify in docker
```
make test_zkp
```
