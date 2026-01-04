# ESPHome Project Template (Docker + VS Code)

Minimalistický veřejný template pro ESPHome projekty bez závislosti na Home Assistant.
Navržený pro práci s Dockerem, Makefile a VS Code (autocomplete, tasks).

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
│   ├── project-esp-doot.yaml
│   └── secrets.yaml
├── .gitignore
├── Makefile
└── .vscode/
    └── tasks.json
```

* název projektu = název zařízení = název YAML souboru
* build adresář `.esphome/` vzniká automaticky a není verzován

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

### Našeptávač (VS Code)

ESPHome YAML autocomplete funguje na základě dynamického schématu.
Po otevření projektu spusť jednou:

```
Terminal → Run Task → ESPHome: Init schema
```

Tento krok:

* spustí `esphome config` nad hlavním YAML
* inicializuje schema
* zajistí plnohodnotné našeptávání i pro `!include` bloky

---

### Build, upload a logy

```bash
make build
make flash
make logs
```

* build i upload probíhá výhradně v Dockeru
* není potřeba lokální instalace ESPHome

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

---

### Secrets

File `esphome_data/secrets.yaml`:

* is generated locally
* ignored by git
* must be filled before building

---

### Autocomplete (VS Code)

After opening the project, run once:

```
Terminal → Run Task → ESPHome: Init schema
```

This initializes the ESPHome YAML schema required for proper autocomplete.

---

### Build, upload and logs

```bash
make build
make flash
make logs
```

---

## License

MIT
