LDFLAGS_FIELD = rom_gen.ld -T linker_field.ld
LDFLAGS_BATTLE = rom_gen.ld -T linker_battle.ld
LDFLAGS_POKEDEX = rom_gen.ld -T linker_pokedex.ld
LDFLAGS_GETMONEVOLUTION = rom_gen.ld -T linker_funcinternal.ld


BATTLE_LINK = $(BUILD)/battle_linked.o
BATTLE_OUTPUT = $(BUILD)/output_battle.bin
OVERLAY_OUTPUTS += $(BATTLE_OUTPUT)
FIELD_LINK = $(BUILD)/field_linked.o
FIELD_OUTPUT = $(BUILD)/output_field.bin
OVERLAY_OUTPUTS += $(FIELD_OUTPUT)
POKEDEX_LINK = $(BUILD)/pokedex_linked.o
POKEDEX_OUTPUT = $(BUILD)/output_pokedex.bin
OVERLAY_OUTPUTS += $(POKEDEX_OUTPUT)
GETMONEVOLUTION_LINK = $(BUILD)/getmonevolution_linked.o
GETMONEVOLUTION_OUTPUT = $(BUILD)/output_getmonevolution.bin
OVERLAY_OUTPUTS += $(GETMONEVOLUTION_OUTPUT)


BATTLE_C_SRCS := $(wildcard $(C_SUBDIR)/battle/*.c)
BATTLE_C_OBJS := $(patsubst $(C_SUBDIR)/%.c,$(BUILD)/%.o,$(BATTLE_C_SRCS))
BATTLE_ASM_SRCS := $(wildcard $(ASM_SUBDIR)/battle/*.s)
BATTLE_ASM_OBJS := $(patsubst $(ASM_SUBDIR)/%.s,$(BUILD)/%.d,$(BATTLE_ASM_SRCS))
BATTLE_OBJS := $(BATTLE_C_OBJS) $(BATTLE_ASM_OBJS) build/thumb_help.d
OVERLAY_OBJS += $(BATTLE_OBJS)

FIELD_C_SRCS := $(wildcard $(C_SUBDIR)/field/*.c)
FIELD_C_OBJS := $(patsubst $(C_SUBDIR)/%.c,$(BUILD)/%.o,$(FIELD_C_SRCS))
FIELD_ASM_SRCS := $(wildcard $(ASM_SUBDIR)/field/*.s)
FIELD_ASM_OBJS := $(patsubst $(ASM_SUBDIR)/%.s,$(BUILD)/%.d,$(FIELD_ASM_SRCS))
FIELD_OBJS := $(FIELD_C_OBJS) $(FIELD_ASM_OBJS) build/thumb_help.d
OVERLAY_OBJS += $(FIELD_OBJS)

POKEDEX_C_SRCS := $(wildcard $(C_SUBDIR)/pokedex/*.c)
POKEDEX_C_OBJS := $(patsubst $(C_SUBDIR)/%.c,$(BUILD)/%.o,$(POKEDEX_C_SRCS))
POKEDEX_ASM_SRCS := $(wildcard $(ASM_SUBDIR)/pokedex/*.s)
POKEDEX_ASM_OBJS := $(patsubst $(ASM_SUBDIR)/%.s,$(BUILD)/%.d,$(POKEDEX_ASM_SRCS))
POKEDEX_OBJS := $(POKEDEX_C_OBJS) $(POKEDEX_ASM_OBJS) build/thumb_help.d
OVERLAY_OBJS += $(POKEDEX_OBJS)

GETMONEVOLUTION_C_SRCS := $(C_SUBDIR)/individual/GetMonEvolutionInternal.c
GETMONEVOLUTION_C_OBJS := $(patsubst $(C_SUBDIR)/%.c,$(BUILD)/%.o,$(GETMONEVOLUTION_C_SRCS))
GETMONEVOLUTION_OBJS := $(GETMONEVOLUTION_C_OBJS) build/thumb_help.d
OVERLAY_OBJS += $(GETMONEVOLUTION_OBJS)


$(FIELD_LINK):$(FIELD_OBJS) rom_gen.ld
	$(LD) $(LDFLAGS_FIELD) -o $@ $(FIELD_OBJS)

$(FIELD_OUTPUT):$(FIELD_LINK)
	$(OBJCOPY) -O binary $< $@

$(BATTLE_LINK):$(BATTLE_OBJS) rom_gen.ld
	$(LD) $(LDFLAGS_BATTLE) -o $@ $(BATTLE_OBJS)

$(BATTLE_OUTPUT):$(BATTLE_LINK)
	$(OBJCOPY) -O binary $< $@

$(POKEDEX_LINK):$(POKEDEX_OBJS) rom_gen.ld
	$(LD) $(LDFLAGS_POKEDEX) -o $@ $(POKEDEX_OBJS)

$(POKEDEX_OUTPUT):$(POKEDEX_LINK)
	$(OBJCOPY) -O binary $< $@

$(GETMONEVOLUTION_LINK):$(GETMONEVOLUTION_OBJS) rom_gen.ld
	$(LD) $(LDFLAGS_GETMONEVOLUTION) -o $@ $(GETMONEVOLUTION_OBJS)

$(GETMONEVOLUTION_OUTPUT):$(GETMONEVOLUTION_LINK)
	$(OBJCOPY) -O binary $< $@

