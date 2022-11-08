build:
	docker build -t transform .

serve:
	docker run transform

redo: build serve