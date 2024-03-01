# source file
set(PROJECT_SOURCES
	device/uart/arm-pl011/driver.c
	device/uart/rtt_console_io.c
)

add_library(platform ${PROJECT_SOURCES})
