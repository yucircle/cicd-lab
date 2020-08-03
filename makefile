TARGET=cicd-lab
PKG=$(TARGET)
TAG=latest
IMAGE_PREFIX?=circleyu
TARGET_IMAGE=$(IMAGE_PREFIX)/$(TARGET):$(TAG)
all: image

$(TARGET):
	CGO_ENABLED=0 GOOS=linux go build -o $(TARGET) $(PKG)

gitlog:

image-build: 
	docker build -t $(TARGET_IMAGE) .

push-image:
	docker push $(TARGET_IMAGE)

.PHONY: 
	image push $(TARGET)

