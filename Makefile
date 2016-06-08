version = $(shell git describe | sed "s|^v||")
name = docker-gdk
vendor = tmaczukin
registry = registry.gitlab.com
image = $(registry)/$(vendor)/$(name)

show_version:
	@echo "Version: $(version)"

build:
	# Building $(image):latest
	@docker build --rm -t $(image):latest .
	# Tagging $(image):$(version)
	@docker tag $(image):latest $(image):$(version)

publish:
	# Pushing $(image):latest
	@time docker push $(image):latest
	# Pushing $(image):$(version)
	@time docker push $(image):$(version)
