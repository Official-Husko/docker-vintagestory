<div align="center">
  <img src="https://media.invisioncic.com/r268468/monthly_2018_02/gamelogo-vintagestory-banner.png.05569bcb37e8009e6c751d354a4dd033.png" alt="Vintage Story Logo" width="200"/>
</div>

# 🛠️ Vintage Story Dedicated Server Docker Image

Run a dedicated [Vintage Story](https://www.vintagestory.at/) server easily using Docker!

---

## 🚀 Quick Start

### 🐳 Docker Compose Example

```yaml
services:
  vsserver:
    image: vintagestory:1.21.0-rc.6-unstable
    container_name: vintagestory-server
    restart: unless-stopped
    volumes:
      - ./gamedata:/gamedata
    ports:
      - 42420:42420
    environment:
      VS_DATA_PATH: /gamedata
```

### 🏃 Docker Run Example

```bash
docker run -d -p 42420:42420 --name vintagestory-server \
  -v $(pwd)/gamedata:/gamedata \
  -e VS_DATA_PATH=/gamedata \
  vintagestory:1.21.0-rc.6-unstable
```

---

## 🔄 Updating Your Server

To update to the latest image:

```bash
docker compose pull
docker compose up -d
```

## 📝 Customizing Server Files

If you use a host volume, simply edit files in your `gamedata` folder. Stop the container, make your changes, and restart.

## 🖥️ TrueNAS Users

If you have issues with host volume mounts, try this Compose file:

```yaml
services:
  vsserver:
    image: vintagestory:1.21.0-rc.6-unstable
    container_name: vintagestory-server
    restart: unless-stopped
    volumes:
      - vsdata:/gamedata
    ports:
      - 42420:42420
    environment:
      VS_DATA_PATH: /gamedata
volumes:
  vsdata:
```

After starting, you may need to edit `/gamedata/vs/serverconfig.json` inside the container.

## 🏁 First Run & Whitelist Info

On first run, you may not be able to connect due to whitelist defaults. Options:

### 🚫 Disable Whitelist

Edit your config:

```json
"StartupCommands": "/whitelist off"
```

Login, add yourself, then re-enable if desired.

### 👤 Add Yourself Manually

Add your UID to `playerswhitelisted.json`:

```json
[
  {
    "PlayerUID": "<UID>",
    "PlayerName": "<NAME>",
    "UntilDate": "2075-01-11T16:59:54.4917519+00:00",
    "Reason": null,
    "IssuedByPlayerName": "Admin"
  }
]
```

## 💡 Useful Startup Commands

Here are some recommended commands for a more casual server experience:

| Command                                    | Description                                                                         |
| ------------------------------------------ | ----------------------------------------------------------------------------------- |
| `/worldconfig toolDurability 2`            | Increase tool durability.                                                           |
| `/worldconfig microblockChiseling all`     | Allow chiseling all blocks.                                                         |
| `/worldConfig propickNodeSearchRadius 8`   | Set prospecting node search radius.                                                 |
| `/worldconfig blockGravity sandgravelsoil` | Enable gravity for earth blocks.                                                    |
| `/worldconfig deathPunishment keep`        | Keep items on death for a more casual experience.                                   |
| `/worldconfig temporalStorms veryrare`     | Make temporal storms very rare.                                                     |
| `/worldconfig temporalRifts off`           | Disable temporal rifts.                                                             |

---

## ❓ Help & Support

- Discord: [Devidian#1334](https://discord.gg/8h3yhUT)
- GitHub Issues: [docker-vintagestory](https://github.com/Devidian/docker-vintagestory)
