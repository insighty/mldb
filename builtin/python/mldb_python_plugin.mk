# This file is part of MLDB. Copyright 2015 mldb.ai inc. All rights reserved.

PYTHON_INTERPRETER_SOURCES := \
	python_interpreter.cc \
	capture_stream.cc \


PYTHON_INTERPRETER_LINK := \
	$(PYTHON_LIBRARY) \
	boost_python3 \
	vfs \

$(eval $(call set_compile_option,$(PYTHON_INTERPRETER_SOURCES),-I$(PYTHON_INCLUDE_PATH)))

$(eval $(call library,python_interpreter,$(PYTHON_INTERPRETER_SOURCES),$(PYTHON_INTERPRETER_LINK)))


PYTHON_PLUGIN_SOURCES := \
	python_plugin.cc \
	python_plugin_context.cc \
	python_entities.cc \
	python_converters.cc \


PYTHON_PLUGIN_LINK := \
	value_description \
	$(PYTHON_LIBRARY) \
	boost_python3 \
	mldb_core \
	mldb_builtin_base \
	python_interpreter \


# Needed so that Python plugin can find its header
$(eval $(call set_compile_option,$(PYTHON_PLUGIN_SOURCES),-I$(PYTHON_INCLUDE_PATH)))

$(eval $(call library,mldb_python_plugin,$(PYTHON_PLUGIN_SOURCES),$(PYTHON_PLUGIN_LINK)))

$(eval $(call include_sub_make,mldb_python_module,module,module.mk))

$(eval $(call include_sub_make,testing))