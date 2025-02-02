#!/usr/bin/env bash
set -eou pipefail

case "$OSTYPE" in
  darwin*)
    case $(uname -m) in
      arm64)  DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-arm64.sh; ;;
      *)      DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-MacOSX-x86_64.sh; ;;
    esac ;;
  linux*)
    case $(uname -m) in
      aarch64) DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-aarch64.sh; ;;
      *)       DOWNLOAD=https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh; ;;
      esac ;;
  *)          echo "unknown: $OSTYPE" ;;
esac

case "$SHELL" in
  *bin/zsh*)   SHELL_NAME=zsh; ;;
  *bin/bash*)  SHELL_NAME=bash ;;
  *bin/fish*) SHELL_NAME=fish ;;
  *)        echo "unknown: $SHELL" ;;
esac

echo Downloading installer...
curl -LO --no-progress-meter $DOWNLOAD
bash Mambaforge-*.sh -b

~/mambaforge/bin/conda init $SHELL_NAME

mamba install jupyterlab

mamba install pytorch torchvision torchaudio pytorch-cuda=11.7 -c pytorch -c nvidia

mamba install ipywidgets

echo "alias jl='jupyter lab --no-browser'" >> ~/.bashrc

echo Please close and reopen your terminal.

