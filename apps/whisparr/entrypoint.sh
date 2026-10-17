#!/usr/bin/env bash
set -euo pipefail

config_value() {
    if [[ -f /config/config.xml ]]; then
        xmlstarlet sel -t -v "/Config/$1" /config/config.xml 2>/dev/null || true
    fi
}

current_log_level="$(config_value LogLevel)"
current_url_base="$(config_value UrlBase)"
current_port="$(config_value Port)"
current_branch="$(config_value Branch)"
current_analytics_enabled="$(config_value AnalyticsEnabled)"
current_api_key="$(config_value ApiKey)"
current_authentication_method="$(config_value AuthenticationMethod)"
current_authentication_required="$(config_value AuthenticationRequired)"
current_instance_name="$(config_value InstanceName)"
current_postgres_user="$(config_value PostgresUser)"
current_postgres_password="$(config_value PostgresPassword)"
current_postgres_port="$(config_value PostgresPort)"
current_postgres_host="$(config_value PostgresHost)"
current_postgres_main_db="$(config_value PostgresMainDb)"
current_postgres_log_db="$(config_value PostgresLogDb)"
current_theme="$(config_value Theme)"

export WHISPARR__LOG_LEVEL="${WHISPARR__LOG_LEVEL:-${current_log_level:-info}}"
export WHISPARR__URL_BASE="${WHISPARR__URL_BASE:-${current_url_base:-}}"
export WHISPARR__PORT="${WHISPARR__PORT:-${current_port:-8989}}"
export WHISPARR__BRANCH="${WHISPARR__BRANCH:-${current_branch:-eros}}"
export WHISPARR__ANALYTICS_ENABLED="${WHISPARR__ANALYTICS_ENABLED:-${current_analytics_enabled:-False}}"
export WHISPARR__API_KEY="${WHISPARR__API_KEY:-${current_api_key:-}}"
export WHISPARR__AUTHENTICATION_METHOD="${WHISPARR__AUTHENTICATION_METHOD:-${current_authentication_method:-External}}"
export WHISPARR__AUTHENTICATION_REQUIRED="${WHISPARR__AUTHENTICATION_REQUIRED:-${current_authentication_required:-DisabledForLocalAddresses}}"
export WHISPARR__INSTANCE_NAME="${WHISPARR__INSTANCE_NAME:-${current_instance_name:-Whisparr}}"
export WHISPARR__POSTGRES_USER="${WHISPARR__POSTGRES_USER:-${current_postgres_user:-}}"
export WHISPARR__POSTGRES_PASSWORD="${WHISPARR__POSTGRES_PASSWORD:-${current_postgres_password:-}}"
export WHISPARR__POSTGRES_PORT="${WHISPARR__POSTGRES_PORT:-${current_postgres_port:-5432}}"
export WHISPARR__POSTGRES_HOST="${WHISPARR__POSTGRES_HOST:-${current_postgres_host:-}}"
export WHISPARR__POSTGRES_MAIN_DB="${WHISPARR__POSTGRES_MAIN_DB:-${current_postgres_main_db:-}}"
export WHISPARR__POSTGRES_LOG_DB="${WHISPARR__POSTGRES_LOG_DB:-${current_postgres_log_db:-}}"
export WHISPARR__THEME="${WHISPARR__THEME:-${current_theme:-auto}}"

umask "${UMASK}"
envsubst < /app/config.xml.tmpl > /config/config.xml.tmp
mv /config/config.xml.tmp /config/config.xml

exec /app/bin/Whisparr --nobrowser --data=/config "$@"
