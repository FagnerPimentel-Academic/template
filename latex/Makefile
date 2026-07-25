# ============================================================================
# Makefile para compilação de documentos LaTeX
# ============================================================================

SHELL := /bin/bash

# Lista de documentos (sem a extensão .tex)
DOCUMENTS := principal ata

# Diretórios
BUILD_DIR := build
OUTPUT_DIR := ..

.PHONY: all clean install_texlive $(DOCUMENTS)

# ============================================================================
# Instalação do TeX Live
# ============================================================================

install_texlive:
	@echo "Installing TeX Live..."
	@sudo apt update -qq
	@sudo apt install -qq -y texlive-full
	@echo "Done."

# ============================================================================
# Compilação
# ============================================================================

define compile_tex
	@echo "=================================================="
	@echo "Compilando $(1).tex"
	@echo "=================================================="

	@mkdir -p $(BUILD_DIR)

	@echo "Step 1/5: pdflatex"
	@pdflatex \
		-shell-escape \
		-synctex=1 \
		-interaction=nonstopmode \
		-file-line-error \
		-output-directory=$(BUILD_DIR) \
		$(1).tex \
		1> $(BUILD_DIR)/$(1).stdout.pdflatex.log \
		2> $(BUILD_DIR)/$(1).stderr.pdflatex.log; \
		echo "Exit code = $$?"

	@echo "Step 2/5: makeglossaries"
	@makeglossaries \
		-d $(BUILD_DIR) \
		$(1) \
		1> $(BUILD_DIR)/$(1).stdout.makeglossaries.log \
		2> $(BUILD_DIR)/$(1).stderr.makeglossaries.log

	@echo "Step 3/5: biber"
	@biber \
		$(BUILD_DIR)/$(1) \
		1> $(BUILD_DIR)/$(1).stdout.biber.log \
		2> $(BUILD_DIR)/$(1).stderr.biber.log

	@echo "Step 4/5: makeindex"
	@openout_any=a makeindex \
		$(BUILD_DIR)/$(1).idx \
		1> $(BUILD_DIR)/$(1).stdout.makeindex.log \
		2> $(BUILD_DIR)/$(1).stderr.makeindex.log

	@echo "Step 5/5: pdflatex"
	@pdflatex \
		-shell-escape \
		-synctex=1 \
		-interaction=nonstopmode \
		-file-line-error \
		-output-directory=$(BUILD_DIR) \
		$(1).tex \
		1>> $(BUILD_DIR)/$(1).stdout.pdflatex.log \
		2>> $(BUILD_DIR)/$(1).stderr.pdflatex.log; \
		echo "Exit code = $$?"

	@cp $(BUILD_DIR)/$(1).pdf $(OUTPUT_DIR)/

	@grep -n \
		-e "Warning:" \
		-e "Error:" \
		-e "Output written on" \
		$(BUILD_DIR)/$(1).stdout.pdflatex.log \
		> $(OUTPUT_DIR)/$(1).output.log || true

	@echo "✓ $(1).pdf gerado."
	@echo
endef

# ============================================================================
# Geração automática dos alvos
# ============================================================================

define create_target
$(1):
	$(call compile_tex,$(1))
endef

$(foreach doc,$(DOCUMENTS),$(eval $(call create_target,$(doc))))

# ============================================================================
# Alvos principais
# ============================================================================

all: $(DOCUMENTS)

clean:
	rm -rf $(BUILD_DIR)
	rm -f $(OUTPUT_DIR)/*.pdf
	rm -f $(OUTPUT_DIR)/*.output.log