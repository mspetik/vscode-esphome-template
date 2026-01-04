#!/usr/bin/env bash
set -e

PROJECT_NAME="$1"

if [ -z "$PROJECT_NAME" ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

TEMPLATE_DIR="$(cd "$(dirname "$0")" && pwd)"
TARGET_DIR="../$PROJECT_NAME"

if [ -d "$TARGET_DIR" ]; then
  echo "Target directory already exists: $TARGET_DIR"
  exit 1
fi

echo "Creating ESPHome project: $PROJECT_NAME"

mkdir "$TARGET_DIR"

rsync -a \
  --exclude .git \
  --exclude init-esphome-project.sh \
  "$TEMPLATE_DIR/" \
  "$TARGET_DIR/"

cd "$TARGET_DIR"

mv esphome_data/vscode-esphome-template.yaml "esphome_data/$PROJECT_NAME.yaml"

sed -i "s/__DEVICE_NAME__/$PROJECT_NAME/g" \
  "esphome_data/$PROJECT_NAME.yaml"

if [ ! -f esphome_data/secrets.yaml ]; then
cat > esphome_data/secrets.yaml <<EOF
wifi_ssid: "CHANGE_ME"
wifi_password: "CHANGE_ME"
ota_password: "CHANGE_ME"
api_key: "CHANGE_ME"
EOF
fi

echo
echo "Project $PROJECT_NAME created."
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  code ."
echo "  edit esphome_data/secrets.yaml"
