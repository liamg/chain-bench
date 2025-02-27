VERSION := $(shell git describe --tags --always)
LDFLAGS=-ldflags "-s -w -X=main.version=$(VERSION)"

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

.PHONY: build
build:
	go build $(LDFLAGS) ./cmd/chain-bench

.PHONY: run
run:
	go run $(LDFLAGS) ./cmd/chain-bench $(RUN_ARGS)

.PHONY: test
test:
	go test -v ./...