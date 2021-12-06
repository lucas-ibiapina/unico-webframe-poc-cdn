run:
	docker run service-name

build-image:
	docker build -t service-name -f build/package/Dockerfile .
