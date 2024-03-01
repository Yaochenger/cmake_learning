# Check the version of cmake
CMAKE_MINIMUM_REQUIRED(VERSION 3.10)

# set(Toolchain_PATH "/home/wangshun/gxr/arm-gnu-toolchain-13.2.Rel1-x86_64-arm-none-eabi/bin")

set(Toolchain_PATH "$ENV{ENV_Toolchain_PATH}")    

set(SOC_PLATFORM "")

# Project type and CPU type
SET(CMAKE_SYSTEM_NAME Generic)
SET(CMAKE_SYSTEM_PROCESSOR cortex-r8)

# Generate compilation information file
SET(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Compilation parameters and tools
SET(CMAKE_C_COMPILER "${Toolchain_PATH}/arm-none-eabi-gcc")
SET(CMAKE_ASM_COMPILER "${Toolchain_PATH}/arm-none-eabi-gcc")
# C compilation parameters
SET(CMAKE_C_FLAGS "-march=armv7-r -mfloat-abi=hard -DNEON -DMPU -ftree-vectorize -ffast-math -mfpu=vfpv3-d16 -O0 -gdwarf-2 -g")
# Assembly compilation parameters
SET(CMAKE_ASM_FLAGS " -march=armv7-r -mfloat-abi=hard -DNEON -DMPU -ftree-vectorize -ffast-math -mfpu=vfpv3-d16 -O0 -c -x assembler-with-cpp -D__ASSEMBLY__ -gdwarf-3 -g")
SET(CMAKE_C_COMPILER_WORKS TRUE)

SET(CMAKE_CXX_COMPILER "${Toolchain_PATH}/arm-none-eabi-g++")
SET(CMAKE_CXX_FLAGS "")
SET(CMAKE_CXX_COMPILER_WORKS TRUE)

SET(CMAKE_OBJCOPY "${Toolchain_PATH}/arm-none-eabi-objcopy")
SET(CMAKE_SIZE "${Toolchain_PATH}/arm-none-eabi-size")

# Link parameters
SET(CMAKE_EXE_LINKER_FLAGS " -Wl,--no-warn-rwx-segments,-u,system_vectors,--gc-sections,-Map=rt-thread.map,-cref,-u, -T ${CMAKE_SOURCE_DIR}/board/jx-soc/arm-cr8/link.ld")

# The types of files included in the project
SET(CMAKE_CXX_STANDARD 14)
PROJECT(rtthread C CXX ASM)

# Header file path
INCLUDE_DIRECTORIES(
	board/jx-soc/arm-cr8
	3rd-party/rt-thread/components/finsh
	3rd-party/rt-thread/include
	3rd-party/rt-thread/libcpu/arm/cortex-r8
	platform/device/uart/snps-dw
	platform/device/uart/arm-pl011
	platform/include/util
	platform/include/device
	platform/include
	platform/device/uart
	out/jx-soc-haps-arm-cr8/rt-thread
)

# macro definition
ADD_DEFINITIONS(
	-DRT_USING_LIBC
	-DRT_USING_NEWLIBC
	-D_POSIX_C_SOURCE=1
	-D__RTTHREAD__
)

# source file
set(PROJECT_SOURCES
	${CMAKE_SOURCE_DIR}/board/jx-soc/arm-cr8/board_rtt.c
)

# Add source files under subfolders
add_subdirectory(3rd-party) 
add_subdirectory(platform) 

# Output executable file
ADD_EXECUTABLE(${CMAKE_PROJECT_NAME}.elf ${PROJECT_SOURCES})

# Link source files in subfolders
target_link_libraries(${CMAKE_PROJECT_NAME}.elf platform)
target_link_libraries(${CMAKE_PROJECT_NAME}.elf 3rd-party)

# User commands
ADD_CUSTOM_COMMAND(TARGET ${CMAKE_PROJECT_NAME}.elf POST_BUILD
COMMAND echo "[Info] Compilation information output for Cortex-R8 project"  
COMMAND ${CMAKE_OBJCOPY} -O binary ${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.bin
COMMAND ${CMAKE_SIZE} ${CMAKE_PROJECT_NAME}.elf)
