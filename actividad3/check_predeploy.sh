
APP_URL="http://127.0.0.1:8080"      
TLS_URL="https://miapp.local:443"    
DNS_NAME="miapp.local"
MAX_LATENCY_MS=500                    
FAIL=0                               

echo "=== Pre-deployment checks ==="

echo -n "HTTP check... "
HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $APP_URL)
if [ "$HTTP_STATUS" -eq 200 ]; then
    echo " OK ($HTTP_STATUS)"
else
    echo " FALLA ($HTTP_STATUS)"
    FAIL=1
fi

echo -n "DNS resolution check... "
RESOLVED_IP=$(getent hosts $DNS_NAME | awk '{print $1}')
if [ -n "$RESOLVED_IP" ]; then
    echo " $DNS_NAME -> $RESOLVED_IP"
else
    echo " no resuelve"
    FAIL=1
fi

echo -n "Latency check... "
LATENCY_MS=$(curl -o /dev/null -s -w "%{time_total}\n" $APP_URL | awk '{printf "%.0f\n",$1*1000}')
echo "$LATENCY_MS ms"
if [ "$LATENCY_MS" -gt "$MAX_LATENCY_MS" ]; then
    echo " Latencia > ${MAX_LATENCY_MS}ms"
    FAIL=1
fi

echo -n "TLS version check... "
TLS_VERSION=$(openssl s_client -connect $(echo $TLS_URL | sed 's|https://||'):443 -servername $DNS_NAME 2>/dev/null | \
              awk '/Protocol  :/ {print $3}')
if [[ "$TLS_VERSION" == "TLSv1.3" ]]; then
    echo " $TLS_VERSION"
else
    echo " $TLS_VERSION (mínimo TLSv1.3 requerido)"
    FAIL=1
fi

# 5️⃣ Resumen y salida
if [ "$FAIL" -eq 0 ]; then
    echo "All checks passed "
    exit 0
else
    echo "Some checks failed "
    exit 1
fi
