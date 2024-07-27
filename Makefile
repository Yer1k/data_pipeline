# Setup containers to run Airflow

docker-spin-up:
	docker compose build && docker compose up airflow-init && docker compose up --build -d 

perms:
	sudo mkdir -p logs plugins temp dags tests data visualization && sudo chmod -R u=rwx,g=rwx,o=rwx logs plugins temp dags tests data visualization

setup-conn:
	docker exec scheduler python /opt/airflow/setup_conn.py

do-sleep:
	sleep 30

up: perms docker-spin-up do-sleep setup-conn

down:
	docker compose down

restart: down up

sh:
	docker exec -ti webserver bash

# Testing
pytest:
	docker exec webserver pytest -p no:warnings -v /opt/airflow/tests

# Auto formatting
format:
	docker exec webserver python -m black -S --line-length 79 .

# Import sorting
isort:
	docker exec webserver isort .

# Static type checking
type:
	docker exec webserver mypy --ignore-missing-imports /opt/airflow

# Linting
lint: 
	docker exec webserver flake8 /opt/airflow/dags

# Run all the above commands
ci: isort format type lint pytest