include env_make

NS = theanimaldock
VERSION ?= latest

REPO = ndocker-consul-haproxy
NAME = consul-haproxy
INSTANCE = default

.PHONY: build

build:
	docker build \
		--rm \
		--tag $(NS)/$(REPO):$(VERSION) .

clean:
	docker rmi \
		--force \
		$(NS)/$(REPO):$(VERSION)

shell:
	docker run \
		--net=host \
		-it \
		$(PORTS) \
		$(VOLUMES) \
		$(ENV) \
		$(NS)/$(REPO):$(VERSION) \
		sh

run:
	docker run \
		--rm \
		--name $(NAME)-$(INSTANCE) \
		$(PORTS) \
		$(VOLUMES) \
		$(ENV) \
		$(NS)/$(REPO):$(VERSION) \
		$(ARGS)

stop:
	docker stop \
		$(NAME)-$(INSTANCE)

push:
	docker push \
		$(NS)/$(REPO):$(VERSION)

default: build

