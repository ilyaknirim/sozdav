#!/usr/bin/env bash
# Test Cloudflare worker notify endpoint
# Set WORKER_URL and sample JSON
WORKER_URL="${WORKER_URL:-https://your-worker.example.workers.dev}"
curl -s -X POST "$WORKER_URL" -H "Content-Type: application/json" -d '{"title":"Тестовый заказ","description":"Проверка нотификации","budget_min":10,"budget_max":20}'
echo
