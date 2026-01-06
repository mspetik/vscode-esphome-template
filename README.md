# ESPHome Project Template (Docker + VS Code)

Minimalistický veřejný template pro ESPHome projekty bez závislosti na Home Assistant.
Navržený pro práci s Dockerem, Makefile a VS Code (autocomplete, tasks).

---

### Co je součástí template

* `docker-compose.yaml` s oficiálním ESPHome obrazem a mountem `./esphome_data` → `/config`
* `Makefile`, který odvozuje název hlavního YAML souboru z názvu složky (např. `project-foo/project-foo.yaml`)
* `.vscode/tasks.json` (validace, build, flash) a `.vscode/extensions.json` (doporučená rozšíření)
* ukázková ESPHome konfigurace `esphome_data/vscode-esphome-template.yaml` s placeholderem `__DEVICE_NAME__`

---

### Účel projektu

Tento repozitář slouží jako **výchozí šablona (template)** pro nové ESPHome projekty.
Cílem je mít:

* čistou strukturu projektu
* žádné závislosti na Home Assistant / Web UI
* deterministický build přes Docker
* pohodlnou práci ve VS Code (našeptávač, Tasks)

Repozitář **není určen přímo k buildu firmware**, ale jako zdroj pro vytvoření nového projektu pomocí init skriptu.

---

### Požadavky

* Docker
* Docker Compose plugin (`docker compose`)
* GNU Make
* VS Code (doporučeno)

---

## Rozšíření pro VS Code

Projekt obsahuje doporučená rozšíření pro VS Code.
Při otevření pracovního prostoru VS Code nabídne jejich instalaci.
---

### Vytvoření nového projektu

1. Naklonuj template repozitář:

```bash
git clone https://github.com/<user>/vscode-esphome-template.git
cd vscode-esphome-template
```

2. Spusť init skript (vytvoří nový projekt vedle template):

```bash
./init-esphome-project.sh project-esp-doot
```

3. Přejdi do nového projektu a otevři ho ve VS Code:

```bash
cd project-esp-doot
code .
```

---

### Struktura výsledného projektu

```text
project-esp-doot/
├── docker-compose.yaml
├── esphome_data/
│   ├── project-esp-doot.yaml  # přejmenováno z template a doplněno o název zařízení
│   └── secrets.yaml
├── .gitignore
├── Makefile
└── .vscode/
    └── tasks.json
```

* název projektu = název zařízení = název YAML souboru
* build adresář `.esphome/` vzniká automaticky a není verzován
* init skript doplní placeholder `__DEVICE_NAME__` a vytvoří prázdné `secrets.yaml`

---

### Secrets

Soubor `esphome_data/secrets.yaml`:

* je generován init skriptem
* je ignorován pomocí `.gitignore`
* **musí být ručně doplněn před buildem**

```yaml
wifi_ssid: "CHANGE_ME"
wifi_password: "CHANGE_ME"
ota_password: "CHANGE_ME"
api_key: "CHANGE_ME"
```

---

### VS Code

Rozšíření doporučená v `.vscode/extensions.json` se nabídnou automaticky (ESPHome, YAML, Docker).
V Tasks (`Terminal → Run Task`) jsou předpřipraveny:

* **ESPHome: Validate config** – `docker compose run --rm esphome config <název_složky>.yaml`
* **ESPHome: Build** – `make build`
* **ESPHome: Flash** – `make flash`
* **ESPHome: Build + Flash** – sekvenční kombinace předešlých úloh

---

### Build, upload a logy

```bash
make build
make flash
make logs
make clean
```

* build i upload probíhá výhradně v Dockeru
* není potřeba lokální instalace ESPHome
* Makefile odvozuje název YAML souboru z názvu složky projektu

---

### Design decisions

* git root je nad ESPHome konfigurací
* `.esphome/` není součástí repozitáře
* `secrets.yaml` se nikdy necommitují
* jeden projekt = jedno zařízení
* žádné implicitní web UI ani Home Assistant závislosti

---

## 🇬🇧 English

### Project purpose

This repository serves as a **starting template** for new ESPHome projects.
The goal is to provide:

* a clean project structure
* no dependency on Home Assistant or Web UI
* deterministic Docker-based builds
* comfortable VS Code workflow (autocomplete, tasks)

This repository itself is **not meant to build firmware**, but to generate new projects using the init script.

---

### What's included

* `docker-compose.yaml` using the official ESPHome image with `./esphome_data` mounted to `/config`
* `Makefile` that derives the main YAML name from the folder name (e.g. `livingroom/livingroom.yaml`)
* `.vscode/tasks.json` (validate, build, flash) and `.vscode/extensions.json` (recommended extensions)
* sample ESPHome config `esphome_data/vscode-esphome-template.yaml` with the `__DEVICE_NAME__` placeholder

---

### Requirements

* Docker
* Docker Compose plugin (`docker compose`)
* GNU Make
* VS Code (recommended)

---

### VS Code Extensions

This project recommends several VS Code extensions.
When opening the workspace, VS Code will prompt you to install them.

---
### Creating a new project

```bash
git clone https://github.com/<user>/template_project-esphome.git
cd template_project-esphome
./init-esphome-project.sh livingroom
cd livingroom
code .
```

---

### Resulting project structure

```text
livingroom/
├── docker-compose.yaml
├── esphome_data/
│   ├── livingroom.yaml
│   └── secrets.yaml
├── .gitignore
├── Makefile
└── .vscode/
    └── tasks.json
```

* project name = device name = YAML filename
* the `.esphome/` build directory is created on demand and is not committed
* init script replaces `__DEVICE_NAME__` and creates an empty `secrets.yaml`

---

### Secrets

File `esphome_data/secrets.yaml`:

* is generated locally
* ignored by git
* must be filled before building

---

### VS Code

Recommended extensions in `.vscode/extensions.json` are offered automatically (ESPHome, YAML, Docker).
Tasks (`Terminal → Run Task`) are ready for:

* **ESPHome: Validate config** – `docker compose run --rm esphome config <folder_name>.yaml`
* **ESPHome: Build** – `make build`
* **ESPHome: Flash** – `make flash`
* **ESPHome: Build + Flash** – sequential combination of the above

---

### Build, upload and logs

```bash
make build
make flash
make logs
make clean
```

* build and upload run inside Docker
* no local ESPHome install is needed
* Makefile derives the YAML filename from the project folder name

---

## License

MIT
