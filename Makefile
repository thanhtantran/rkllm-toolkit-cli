# Tên Docker image
IMAGE_NAME=rkllm-cli
DOCKER_USER=thanhtantran
TAG=latest

# Tên đầy đủ để push lên Docker Hub
FULL_IMAGE_NAME=$(DOCKER_USER)/$(IMAGE_NAME):$(TAG)

.PHONY: all build tag push clean

# Build Docker image
build:
	docker build -t $(IMAGE_NAME) .

# Gắn tag Docker image để chuẩn bị push lên Docker Hub
tag:
	docker tag $(IMAGE_NAME) $(FULL_IMAGE_NAME)

# Push image đã gắn tag lên Docker Hub
push: tag
	docker push $(FULL_IMAGE_NAME)

# Dọn dẹp các image tạm nếu cần
clean:
	docker rmi $(IMAGE_NAME) $(FULL_IMAGE_NAME) || true
