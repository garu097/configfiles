#!/usr/bin/env bash

PREFIX="$1"

# Chuyển sang nhánh an toàn trước
git checkout main >/dev/null 2>&1 || git checkout master >/dev/null 2>&1

if [ -z "$PREFIX" ]; then
  echo "Không truyền prefix → Sẽ xóa tất cả nhánh local (trừ main/master)"
  
  git branch | grep -Ev "^\*|main|master" | while read BRANCH; do
    BRANCH=$(echo "$BRANCH" | xargs) # trim spaces
    if [ ! -z "$BRANCH" ]; then
      echo "Xóa nhánh: $BRANCH"
      git branch -D "$BRANCH"
    fi
  done

else
  echo "Xóa toàn bộ nhánh local có prefix: $PREFIX"

  git branch --list "${PREFIX}*" | while read BRANCH; do
    BRANCH=$(echo "$BRANCH" | xargs) # trim spaces
    if [ ! -z "$BRANCH" ]; then
      echo "Xóa nhánh: $BRANCH"
      git branch -D "$BRANCH"
    fi
  done
fi

echo "Hoàn thành!"