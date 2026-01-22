## For macos

sudo rm -f /usr/local/bin/docker* \
           /usr/local/bin/hub-tool \
           /usr/local/bin/kubectl.docker \
           /usr/local/bin/com.docker.cli

sudo rm -f /opt/homebrew/bin/docker* \
           /opt/homebrew/bin/hub-tool \
           /opt/homebrew/bin/kubectl.docker \
           /opt/homebrew/bin/com.docker.cli

brew uninstall --cask docker
brew cleanup docker

pkill Docker

# Xóa thư mục VM cũ
rm -rf ~/Library/Containers/com.docker.docker
rm -rf ~/Library/Group\ Containers/group.com.docker