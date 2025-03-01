#!/bin/bash
# The script shoud be invoked from the directory where the Packer template was created.
VAGRANT_BOX_NAME=$(ls *.box)
CURRENT_DIR=$(pwd)
TMP_DIR="/tmp/vagrant-box"
mkdir -pv "$TMP_DIR"
tar xvf "$VAGRANT_BOX_NAME" --directory "$TMP_DIR"
echo '{ "architecture": "arm64" , "provider": "vmware_fusion" }' | jq '.' > "$TMP_DIR/metadata.json"
cd "$TMP_DIR"
GZIP=-9 tar zcvf "${VAGRANT_BOX_NAME}.tar.gz" *
cd "$CURRENT_DIR"
mv -f "${TMP_DIR}/${VAGRANT_BOX_NAME}.tar.gz" .
