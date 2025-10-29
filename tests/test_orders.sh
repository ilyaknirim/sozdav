#!/usr/bin/env bash
# Fill SUPABASE_URL and ANON_KEY before running
SUPABASE_URL="${SUPABASE_URL:-https://your-project.supabase.co}"
ANON_KEY="${ANON_KEY:-your-anon-key}"

echo "GET orders..."
curl -s -H "apikey: $ANON_KEY" -H "Authorization: Bearer $ANON_KEY" "$SUPABASE_URL/rest/v1/orders?select=*"

echo "\nPOST test order..."
curl -s -X POST "$SUPABASE_URL/rest/v1/orders" -H "apikey: $ANON_KEY" -H "Authorization: Bearer $ANON_KEY" -H "Content-Type: application/json" -d '{"title":"smoke test","description":"from tests/test_orders.sh","lat":57.82,"lng":28.33,"budget_min":1,"budget_max":2,"status":"open","created_at":"2025-10-29"}'
echo
