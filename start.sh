#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

if ! command -v java >/dev/null 2>&1; then
  echo "Java nao foi encontrado. Reabra o Codespace e aguarde a instalacao da feature Java 25."
  exit 1
fi

if [ ! -f server.jar ]; then
  echo "Baixando a versao estavel mais recente do Minecraft..."
  python3 - <<'PY'
import json, urllib.request, hashlib, pathlib, sys
base = "https://piston-meta.mojang.com/mc/game/version_manifest_v2.json"
with urllib.request.urlopen(base) as r:
    manifest = json.load(r)
version_id = manifest["latest"]["release"]
version_entry = next(v for v in manifest["versions"] if v["id"] == version_id)
with urllib.request.urlopen(version_entry["url"]) as r:
    metadata = json.load(r)
server = metadata["downloads"]["server"]
with urllib.request.urlopen(server["url"]) as r:
    data = r.read()
actual = hashlib.sha1(data).hexdigest()
if actual != server["sha1"]:
    print("Falha na verificacao SHA-1 do server.jar.", file=sys.stderr)
    sys.exit(1)
pathlib.Path("server.jar").write_bytes(data)
pathlib.Path("minecraft-version.txt").write_text(version_id + "\n")
print("Minecraft Java " + version_id + " baixado e verificado.")
PY
fi

if [ ! -f eula.txt ]; then
  printf 'eula=false\n' > eula.txt
fi

if ! grep -q '^eula=true$' eula.txt; then
  echo ""
  echo "Antes de iniciar, leia e aceite a EULA em https://aka.ms/MinecraftEULA."
  echo "Se concordar, altere eula=false para eula=true no arquivo eula.txt."
  exit 0
fi

if [ ! -f server.properties ]; then
  cat > server.properties <<'PROPS'
server-port=25565
server-ip=
max-players=5
online-mode=true
motd=Servidor Vanilla
view-distance=6
simulation-distance=4
PROPS
fi

echo "Iniciando Minecraft Java Vanilla..."
exec java -Xms1G -Xmx2G -jar server.jar nogui
