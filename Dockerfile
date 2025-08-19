# ============== download stage ==================
FROM debian:latest as downloader

WORKDIR /download

ARG vs_type=unstable
ARG vs_os=linux-x64
ARG vs_version=1.21.0-rc.6

RUN apt update
RUN apt install -y wget

RUN wget "https://cdn.vintagestory.at/gamefiles/${vs_type}/vs_server_${vs_os}_${vs_version}.tar.gz"
RUN tar -xvzf "vs_server_${vs_os}_${vs_version}.tar.gz"
RUN rm "vs_server_${vs_os}_${vs_version}.tar.gz"

# ============== runtime stage ==================
FROM mcr.microsoft.com/dotnet/sdk:8.0 as runtime
WORKDIR /game
# Defaults
ENV VS_DATA_PATH=/gamedata/vs
COPY --from=downloader "./download/" "/game"
COPY replacements/ /game/

#  Expose ports
EXPOSE 42420

# Execution command
CMD  dotnet VintagestoryServer.dll --dataPath $VS_DATA_PATH
