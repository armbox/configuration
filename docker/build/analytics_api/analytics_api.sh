#!/usr/bin/env bash

# Ansible managed



export EDX_REST_API_CLIENT_NAME="default_env-default_deployment-analytics_api"

source /edx/app/analytics_api/analytics_api_env
/edx/app/analytics_api/venvs/analytics_api/bin/gunicorn -c /edx/app/analytics_api/analytics_api_gunicorn.py  analyticsdataserver.wsgi:application
