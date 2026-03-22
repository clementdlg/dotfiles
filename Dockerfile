FROM alpine:3.23
ARG REPO="github.com:clementdlg/dotfiles.git"
ARG USER="steve"
ARG HOME="/home/$USER"
ARG XDG_CONFIG_HOME="${HOME}/.config"
ARG PATH="$XDG_CONFIG_HOME/ansible/.venv/bin:$XDG_CONFIG_HOME/nodejs/node_modules/.bin:$PATH"
ENV PATH="$PATH"

# alpine packages
COPY alpine.txt .
RUN apk add --no-cache $(cat alpine.txt | tr '\n' ' ')
COPY --from=oven/bun:alpine /usr/local/bin/bun /usr/local/bin/bun
RUN ln -s /usr/local/bin/bun /usr/local/bin/node
RUN ln -Tfs /usr/lib/tree-sitter /usr/share/nvim/runtime/parser

# setup user
RUN adduser -h "$HOME" -D "$USER"
ADD --chown="$USER" https://github.com/clementdlg/dotfiles.git "$HOME/.config"
USER "$USER"
WORKDIR "$HOME"
RUN mkdir -p "$HOME/.local/bin" "$HOME/.local/share"

# nodejs
WORKDIR "$XDG_CONFIG_HOME/nodejs"
RUN bun ci --production

# ansible
WORKDIR "$XDG_CONFIG_HOME/ansible"
RUN uv python install && uv sync

# neovim
RUN nvim -l "$XDG_CONFIG_HOME/nvim/init.lua"
