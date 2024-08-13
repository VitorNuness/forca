all: coverage.xml

coverage.xml: .coverage
	coverage xml

htmlcov: .coverage
	coverage html

.coverage: *.py
	coverage run -m unittest main.py


scan:
	podman run \
		--rm \
		--security-opt label=disable \
		-e SONAR_HOST_URL="http://host.containers.internal:9000"  \
		-w "${PWD}" \
		-v "${PWD}:${PWD}" \
		docker.io/sonarsource/sonar-scanner-cli \
		-Dsonar.login="admin" \
		-Dsonar.password="senha"

test:
	python -m unittest main.py
