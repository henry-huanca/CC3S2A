
# Detecta TLS
tls_version=$(openssl s_client -connect miapp.local:443 -servername miapp.local 2>/dev/null | \
    awk '/Protocol  :/ {print $3}' | tr -d '\r\n')

echo "TLS detectado: $tls_version"

case "$tls_version" in
    TLSv1.0) ver_num=1 ;;
    TLSv1.1) ver_num=2 ;;
    TLSv1.2) ver_num=3 ;;
    TLSv1.3) ver_num=4 ;;
    TLSv1.4) ver_num=5 ;;  # en el futuro
    *) ver_num=0 ;;         # desconocido
esac

# TLS mínimo requerido: 1.3 (ver_num >= 4)
if [[ "$ver_num" -ge 4 ]]; then
    echo "✅ TLS cumple con el mínimo requerido"
    exit 0
else
    echo "❌ TLS mínimo v1.3 requerido. Falla el job."
    exit 1
fi
