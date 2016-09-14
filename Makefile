all: container

# 0.0 shouldn't clobber any released builds
TAG = 0.1
PREFIX = gcr.io/jntlserv0/git-sync

binary: main.go
	CGO_ENABLED=0 GOOS=linux godep go build -a -installsuffix cgo -ldflags '-w' -o git-sync

container: binary
	docker build -t $(PREFIX):$(TAG) .

#push: container
#	gcloud docker push $(PREFIX):$(TAG)

clean:
	docker rmi -f $(PREFIX):$(TAG) || true
