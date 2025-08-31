import os
from dotenv import load_dotenv
from pathlib import Path
from datetime import timedelta


load_dotenv()

BASE_DIR = Path(__file__).resolve().parent.parent

SECRET_KEY = (
    os.getenv('SECRET_KEY')
)

DEBUG = True

# Permitirá o acesso somente se o usuário estiver conectado via VPN.
ALLOWED_HOSTS = ['*']

INSTALLED_APPS = [
    'django_admin_dracula',
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    'rest_framework',
    'django_filters',
    'app',
    'accounts',
    'credit_cards',
    'expenses',
    'loans',
    'members',
    'revenues',
    'transfers'
]

MIDDLEWARE = [
    'app.middleware.SecurityHeadersMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'app.middleware.AuditLoggingMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
]

ROOT_URLCONF = 'app.urls'

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
            ],
        },
    },
]

WSGI_APPLICATION = 'app.wsgi.application'

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': os.getenv('DB_NAME'),
        'USER': os.getenv('DB_USER'),
        'PASSWORD': os.getenv('DB_PASSWORD'),
        'HOST': os.getenv('DB_HOST'),
        'PORT': os.getenv('DB_PORT', 5432)
    }
}

# Use SQLite for tests to avoid database connection issues
import sys  # type: ignore
if 'test' in sys.argv:
    DATABASES['default'] = {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': ':memory:'
    }

AUTH_PASSWORD_TYPES = [
    'UserAttributeSimilarityValidator',
    'MinimumLengthValidator',
    'CommonPasswordValidator',
    'NumericPasswordValidator'
]

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': f'django.contrib.auth.password_validation.{
            AUTH_PASSWORD_TYPES[0]
        }',
    },
    {
        'NAME': f'django.contrib.auth.password_validation.{
            AUTH_PASSWORD_TYPES[1]
        }',
    },
    {
        'NAME': f'django.contrib.auth.password_validation.{
            AUTH_PASSWORD_TYPES[2]
        }',
    },
    {
        'NAME': f'django.contrib.auth.password_validation.{
            AUTH_PASSWORD_TYPES[3]
        }',
    },
]

LANGUAGE_CODE = 'pt-BR'
TIME_ZONE = 'America/Sao_Paulo'
USE_I18N = True
USE_TZ = True

STATIC_URL = '/static/'
STATIC_ROOT = os.path.join(BASE_DIR, 'staticfiles')

DEFAULT_AUTO_FIELD = 'django.db.models.BigAutoField'


SIMPLE_JWT = {
    "ACCESS_TOKEN_LIFETIME": timedelta(minutes=15),
    "REFRESH_TOKEN_LIFETIME": timedelta(hours=1),
}

MEDIA_ROOT = os.path.join(BASE_DIR, 'media')
MEDIA_URL = '/media/'

# REST Framework Configuration
REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework_simplejwt.authentication.JWTAuthentication',
    ),
    'DEFAULT_FILTER_BACKENDS': [
        'django_filters.rest_framework.DjangoFilterBackend',
    ],
}

# Caching Configuration
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.locmem.LocMemCache',
        'LOCATION': 'unique-snowflake',
    }
}

# Structured Logging Configuration
LOGGING = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'json': {
            '()': 'pythonjsonlogger.jsonlogger.JsonFormatter',
            'format': '%(asctime)s %(name)s %(levelname)s %(message)s'
        },
        'verbose': {
            'format': '{levelname} {asctime} {module} {process:d} {thread:d} {message}',
            'style': '{',
        },
        'simple': {
            'format': '{levelname} {message}',
            'style': '{',
        },
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'json' if os.getenv('LOG_FORMAT') == 'json' else 'verbose',
        },
    },
    'loggers': {
        'django': {
            'handlers': ['console'],
            'level': 'INFO',
            'propagate': True,
        },
        'expenselit': {
            'handlers': ['console'],
            'level': 'INFO',
            'propagate': False,
        },
        'expenselit.audit': {
            'handlers': ['console'],
            'level': 'INFO',
            'propagate': False,
        },
    },
    'root': {
        'handlers': ['console'],
        'level': 'WARNING',
    },
}

# Create logs directory if it doesn't exist
logs_dir = os.path.join(BASE_DIR, 'logs')
os.makedirs(logs_dir, exist_ok=True)
