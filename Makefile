version = latest
name = gitlab-dev
vendor = tmaczukin
image = $(vendor)/$(name)

build:
	@docker build --rm -t $(image):latest .
	@docker tag $(image):latest $(image):$(version)
