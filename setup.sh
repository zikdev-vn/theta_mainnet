#!/bin/bash

# Tên phiên screen
SCREEN_NAME="theta_mainnet"

# Tạo phiên screen
echo "Creating a screen session: $SCREEN_NAME"
screen -dmS $SCREEN_NAME

# Thiết lập thư mục
NODE_DIR=~/theta_mainnet
BIN_DIR=$NODE_DIR/bin
NODE_CONFIG_DIR=$NODE_DIR/guardian_mainnet/node

echo "Creating necessary directories..."
mkdir -p $BIN_DIR
mkdir -p $NODE_CONFIG_DIR

# Tải tệp nhị phân (theta và thetacli)
echo "Downloading Theta binaries..."
curl -k --output $BIN_DIR/theta `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=theta'`
curl -k --output $BIN_DIR/thetacli `curl -k 'https://mainnet-data.thetatoken.org/binary?os=linux&name=thetacli'`

# Tải snapshot và config.yaml
echo "Downloading snapshot and config file..."
wget -O $NODE_CONFIG_DIR/snapshot `curl -k https://mainnet-data.thetatoken.org/snapshot`
curl -k --output $NODE_CONFIG_DIR/config.yaml `curl -k 'https://mainnet-data.thetatoken.org/config?is_guardian=true'`

# Cấp quyền thực thi cho tệp nhị phân
echo "Setting executable permissions..."
chmod +x $BIN_DIR/theta
chmod +x $BIN_DIR/thetacli

# Thông báo hoàn tất
echo "Setup completed! To start your node, use:"
echo "  screen -r $SCREEN_NAME"
echo "  cd $BIN_DIR"
echo "  ./theta start --config=../guardian_mainnet/node/config.yaml"
