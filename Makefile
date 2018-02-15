SRC_DIR = src
OUT_DIR = dist
YAMLS = $(wildcard $(SRC_DIR)/*.yaml)
JSONS = $(patsubst $(SRC_DIR)/%.yaml,$(OUT_DIR)/%.json,$(YAMLS))

.DEFAULT_GOAL = all
.PHONY = install

all: $(JSONS)

$(OUT_DIR)/%.json: $(SRC_DIR)/%.yaml $(OUT_DIR)
	@yaml2json < $< | jq '.Rules = (.Rules | @text)' > $@

$(OUT_DIR):
	@mkdir -p ${OUT_DIR}

install:
	@./install.sh
