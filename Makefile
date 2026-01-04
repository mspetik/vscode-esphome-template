ESPHOME = docker compose run --rm esphome
PROJECT = $(notdir $(CURDIR))
YAML = $(PROJECT).yaml

build:
	$(ESPHOME) compile $(YAML)

flash:
	$(ESPHOME) upload $(YAML)

logs:
	$(ESPHOME) logs $(YAML)

clean:
	rm -rf esphome_data/.esphome
