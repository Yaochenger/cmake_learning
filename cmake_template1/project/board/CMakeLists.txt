# Add Source file
set(PROJECT_SOURCES
	jx-soc/arm-cr8/board_rtt.c
)

# Generate Library Files
add_library(board ${PROJECT_SOURCES})
