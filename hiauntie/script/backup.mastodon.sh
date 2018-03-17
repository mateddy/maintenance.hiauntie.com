#!/bin/bash

set -e

mkdir -p /tmp/XFJXIDUJ-backup
pg_dump mastodon_production > /tmp/XFJXIDUJ-backup/mastodon_production.sql
