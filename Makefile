version = $(shell git describe | sed "s|^v||")
name = docker-gdk
vendor = tmaczukin
registry = registry.gitlab.com
image = $(registry)/$(vendor)/$(name)

build:
	# Building $(image):latest
	@docker build --rm -t $(image):latest .
	# Tagging $(image):$(version)
	@docker tag $(image):latest $(image):$(version)

publish:
	# Pushing $(image):latest
	@docker push $(image):latest
	# Pushing $(image):$(version)
	@docker push $(image):$(version)
