PROJECT_NAME := $(shell basename $(CURDIR))
image_name := compsy/$(PROJECT_NAME)
action_name := $(PROJECT_NAME)

exists := $(strip $(shell bx wsk action list | awk '{print $1}' | grep $(action_name)))

.DEFAULT_GOAL := all

docker: build push
all: build push service

build:
	@echo "Building $(image_name) to dockerhub"
	sudo docker build -t $(image_name) .

push:
	@echo "Pushing $(image_name) to dockerhub"
	sudo docker push $(image_name)

service:
ifndef exists
	bx wsk action create $(action_name) --docker $(image_name)
else
	bx wsk action update $(action_name) --docker $(image_name)
endif

action:
	@echo "Creating action $(action_name) for docker image $(image_name)"
	bx wsk action create $(action_name) --web true --docker $(image_name)

update:
	@echo "Updating action $(action_name) for docker image $(image_name)"
	bx wsk action update $(action_name) --docker $(image_name)

name:
	@echo $(PROJECT_NAME)
