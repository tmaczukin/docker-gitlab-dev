version = $(shell git describe | sed "s|^v||")
name = docker-gdk
vendor = tmaczukin
registry = registry.gitlab.com
image = $(registry)/$(vendor)/$(name)

build:
	@docker build --rm -t $(image):latest .
	@docker tag $(image):latest $(image):$(version)

publish:
	@docker push $(image):latest
	@docker push $(image):$(version)
