# ExpenseLit API - Makefile

# Variables
PYTHON = python
PIP = pip
DJANGO = $(PYTHON) manage.py

# Help
.PHONY: help
help:
	@echo "ExpenseLit API - Available commands:"
	@echo ""
	@echo "Setup & Dependencies:"
	@echo "  install          Install dependencies"
	@echo "  install-dev      Install dev dependencies"
	@echo "  requirements     Generate requirements.txt"
	@echo ""
	@echo "Database:"
	@echo "  migrate          Run database migrations"
	@echo "  makemigrations   Create new migrations"
	@echo "  reset-db         Reset database (WARNING: destroys data)"
	@echo "  superuser        Create superuser"
	@echo ""
	@echo "Testing:"
	@echo "  test             Run all tests"
	@echo "  test-unit        Run unit tests only"
	@echo "  test-api         Run API tests only"
	@echo "  test-models      Run model tests only"
	@echo "  test-views       Run view tests only"
	@echo "  test-serializers Run serializer tests only"
	@echo "  test-permissions Run permission tests only"
	@echo "  test-encryption  Run encryption tests only"
	@echo "  test-coverage    Run tests with coverage report"
	@echo ""
	@echo "Code Quality:"
	@echo "  lint             Run linting (flake8)"
	@echo "  format           Format code (black)"
	@echo "  check            Run all quality checks"
	@echo ""
	@echo "Development:"
	@echo "  runserver        Start development server"
	@echo "  shell            Start Django shell"
	@echo "  collectstatic    Collect static files"
	@echo "  clean            Clean cache and temp files"
	@echo ""
	@echo "Docker:"
	@echo "  docker-build     Build Docker image"
	@echo "  docker-run       Run Docker container"
	@echo "  docker-stop      Stop Docker container"
	@echo ""
	@echo "Encryption:"
	@echo "  generate-key     Generate new encryption key"

# Setup & Dependencies
.PHONY: install
install:
	$(PIP) install -r requirements.txt

.PHONY: install-dev
install-dev:
	$(PIP) install -r requirements.txt
	$(PIP) install pytest pytest-django pytest-cov black flake8 isort

.PHONY: requirements
requirements:
	$(PIP) freeze > requirements.txt

# Database
.PHONY: migrate
migrate:
	$(DJANGO) migrate

.PHONY: makemigrations
makemigrations:
	$(DJANGO) makemigrations

.PHONY: reset-db
reset-db:
	@echo "WARNING: This will destroy all data in the database!"
	@read -p "Are you sure? [y/N] " -n 1 -r; \
	echo; \
	if [[ $$REPLY =~ ^[Yy]$$ ]]; then \
		find . -path "*/migrations/*.py" -not -name "__init__.py" -delete; \
		find . -path "*/migrations/*.pyc" -delete; \
		rm -f db.sqlite3; \
		$(DJANGO) makemigrations; \
		$(DJANGO) migrate; \
	fi

.PHONY: superuser
superuser:
	$(DJANGO) createsuperuser

# Testing
.PHONY: test
test:
	pytest

.PHONY: test-unit
test-unit:
	pytest -m "unit"

.PHONY: test-api
test-api:
	pytest -m "api"

.PHONY: test-models
test-models:
	pytest -m "models"

.PHONY: test-views
test-views:
	pytest -m "views"

.PHONY: test-serializers
test-serializers:
	pytest -m "serializers"

.PHONY: test-permissions
test-permissions:
	pytest -m "permissions"

.PHONY: test-encryption
test-encryption:
	pytest -m "encryption"

.PHONY: test-coverage
test-coverage:
	pytest --cov=. --cov-report=html --cov-report=term-missing

# Code Quality
.PHONY: lint
lint:
	flake8 .

.PHONY: format
format:
	black .
	isort .

.PHONY: check
check: lint test

# Development
.PHONY: runserver
runserver:
	$(DJANGO) runserver

.PHONY: shell
shell:
	$(DJANGO) shell

.PHONY: collectstatic
collectstatic:
	$(DJANGO) collectstatic --noinput

.PHONY: clean
clean:
	find . -type f -name "*.pyc" -delete
	find . -type d -name "__pycache__" -delete
	find . -name "*.orig" -delete
	rm -rf .pytest_cache/
	rm -rf htmlcov/
	rm -rf .coverage

# Docker
.PHONY: docker-build
docker-build:
	docker build . -t expenselit-api

.PHONY: docker-run
docker-run:
	docker run -p 8002:8002 --env-file .env expenselit-api

.PHONY: docker-stop
docker-stop:
	docker stop $(shell docker ps -q --filter ancestor=expenselit-api)

# Encryption
.PHONY: generate-key
generate-key:
	@$(PYTHON) -c "from cryptography.fernet import Fernet; print('ENCRYPTION_KEY=' + Fernet.generate_key().decode())"

# Docker Compose Commands
.PHONY: up down logs build-compose health backup docs-generate
up:
	@echo "Starting development environment with Docker Compose..."
	docker-compose up -d
	@echo "Application available at: http://localhost:8002"
	@echo "Health check: http://localhost:8002/health/"

down:
	@echo "Stopping Docker Compose environment..."
	docker-compose down

logs:
	@echo "Showing Docker Compose logs..."
	docker-compose logs -f

build-compose:
	@echo "Building Docker Compose images..."
	docker-compose build --no-cache

health:
	@echo "Checking application health..."
	@curl -f http://localhost:8002/health/ 2>/dev/null | python -c "import sys,json; data=json.load(sys.stdin); print(f\"Status: {data['status']}\"); [print(f\"  {k}: {v['status']} - {v['message']}\") for k,v in data['checks'].items()]" || echo "Health check failed - service may be down"

backup:
	@echo "Creating backup..."
	@if [ -f ./scripts/backup.sh ]; then \
		./scripts/backup.sh; \
	else \
		echo "Backup script not found. Run: chmod +x scripts/backup.sh"; \
	fi

docs-generate:
	@echo "Generating project documentation..."
	@if [ -f ./generate_docs.py ]; then \
		$(PYTHON) generate_docs.py; \
	else \
		echo "Documentation generator not found."; \
	fi

# Advanced Development Commands
.PHONY: shell-compose migrate-compose reset-compose
shell-compose:
	@echo "Accessing Django shell in Docker container..."
	docker-compose exec app python manage.py shell

migrate-compose:
	@echo "Running migrations in Docker container..."
	docker-compose exec app python manage.py makemigrations
	docker-compose exec app python manage.py migrate

reset-compose:
	@echo "Resetting Docker environment..."
	docker-compose down -v
	docker-compose up -d

# Production Commands
.PHONY: prod-deploy prod-logs prod-health
prod-deploy:
	@echo "Deploying to production with Docker Stack..."
	docker build -t expenselit-api:latest .
	docker stack deploy -c expenselit-api.yml expenselit-api

prod-logs:
	@echo "Showing production logs..."
	docker service logs expenselit-api_app -f

prod-health:
	@echo "Checking production health..."
	@curl -f http://localhost:8002/health/ || echo "Production health check failed"

# Database Operations
.PHONY: db-shell db-backup-compose
db-shell:
	@echo "Accessing database shell..."
	docker-compose exec db psql -U $$DB_USER -d expenselit

db-backup-compose:
	@echo "Creating database backup..."
	mkdir -p ./backups
	docker-compose exec db pg_dump -U $$DB_USER -d expenselit > ./backups/db_backup_$$(date +%Y%m%d_%H%M%S).sql
	@echo "Database backup created in ./backups/"

# Default target
.DEFAULT_GOAL := help